import 'dart:io';

import 'package:clini_app/controllers/controllers.dart';
import 'package:clini_app/routes/routes.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/ui/consent/consent.dart';
import 'package:clini_app/ui/signature_pad/signature_pad.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ConsentScreen extends StatefulWidget {
  final ConsentScreenArgs args;
  const ConsentScreen(this.args);

  @override
  _ConsentScreenState createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {
  final _isSignatureDone = ValueNotifier(false);
  ByteData? image;
  File? pdfFile;
  late StudyNotifier _notifier;
  @override
  void initState() {
    super.initState();
    _notifier = context.read<StudyNotifier>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CliniAppBar(title: widget.args.title!),
      body: ValueListenableBuilder(
        valueListenable: _isSignatureDone,
        builder: (_, __, ___) {
          return AppWidgetSlider(
            onBackPress: _handleBackPress,
            onNextPress: _handleNextPress,
            children: [
              ConsentStudyScreen(
                url: widget.args.videoUrl,
                studyName: widget.args.studyName,
              ),
              ValueListenableBuilder(
                valueListenable: _isSignatureDone,
                builder: (_, __, ___) => ConsentPdfScreen(
                  onTap: openSignaturePad,
                  args: widget.args,
                  onrest: openSignaturePad,
                ),
              ),
              ConsentSuccessScreen(
                onTap: () {
                  saveData();
                  AppEnvironment.navigator.pushNamedAndRemoveUntil(
                    ConsentRoutes.consentPreviewScreen,
                    (route) => route.isFirst,
                  );
                  // AppEnvironment.navigator.pushNamedAndRemoveUntil(GeneralRoutes.navbar, (route) => route.isFirst);
                  // AppEnvironment.navigator.pushReplacementNamed(ConsentRoutes.consentPreviewScreen);
                  // TODO: open success screen click here
                },
              ),
              // ConsentPdfViewer(pdf: pdfFile)
            ],
          );
        },
      ),
    );
  }

  bool _handleBackPress(int val) {
    switch (val) {
      case 0:
        return false;
      case 1:
        return true;
      case 2:
        return false;
      case 3:
        return false;
      default:
        return true;
    }
  }

  Future<bool> _handleNextPress(int val) async {
    switch (val) {
      case 0:
        return _handlePdfDownload();
      case 1:
        if (!_isSignatureDone.value) {
          openSignaturePad();
        }
        return _isSignatureDone.value;
      case 2:
        // await saveData();
        return _isSignatureDone.value;
      case 3:
        AppEnvironment.navigator.pop();
        return _isSignatureDone.value;
      default:
        return true;
    }
  }

  Future<void> openSignaturePad() async {
    await _handlePdfDownload();
    image = null;
    _isSignatureDone.value = false;
    context.showWidgetDialog(
      SignaturePadView(
        onSuccess: _handleSignatureSuccess,
      ),
    );
  }

  Future<void> _handleSignatureSuccess(ByteData data) async {
    context.showLoadingIndicator();

    final doc = PdfDocument(inputBytes: pdfFile?.readAsBytesSync());
    final image = PdfBitmap(data.buffer.asUint8List());
    //x =210  y =297  A4
    var widthOfPage = doc.pageSettings.width;
    var heightOfPage = doc.pageSettings.height;
    widget.args.model?.annotations?.entries.toList().forEach((element) {
      for (var sign in element.value.toSet()..toList()) {
        Logger.logMsg(this, sign.toJson());
        var xLoc = (((sign.xLoc ?? 0) / 210.0) * widthOfPage);
        var yLoc = (((sign.yLoc ?? 0) / 330.0) * heightOfPage);
        if (sign.annotation!.contains('date')) {
          doc.pages[element.key - 1].graphics.drawString(
              DateTime.now().onlyDate.toString().split(' ').first,
              PdfStandardFont(PdfFontFamily.helvetica, 14),
              bounds: Rect.fromLTWH(xLoc + 10.h, yLoc + 10.h, 150.w, 20.h));
        } else {
          if (sign.annotation!.contains('signature')) {
            doc.pages[element.key - 1].graphics.drawImage(
              image,
              Rect.fromLTWH(
                xLoc,
                yLoc,
                100.w,
                45.h,
              ),
            );
          }
        }
      }
    });

    pdfFile?.writeAsBytes(doc.save());
    await savePdfDocument(doc.save());
    context.removeLoadingIndicator();
    AppEnvironment.navigator.pop();
    _isSignatureDone.value = true;
    // _isSignatureDone.value = false;
  }

  Future<bool> _handlePdfDownload() async {
    context.showLoadingIndicator();
    final resp = await context.downloadFile(
      widget.args.pdfUrl!,
      DateTime.now().microsecondsSinceEpoch.toString() + '.pdf',
    );

    context.removeLoadingIndicator();
    if (resp.isSuccess) {
      pdfFile = resp.data;
      widget.args.pdfFile = pdfFile;
      return true;
    }
    context.showErrorSnackBar(resp.message);
    return false;
  }

  Future saveData() async {
    context.showLoadingIndicator();
    _notifier.showLoader();

    _notifier.consentFormPDf = pdfFile?.path ?? '';

    _notifier.removeLoader();
    context.removeLoadingIndicator();
  }

  Future<void> savePdfDocument(List<int> data) async {
    final dir = (await getApplicationDocumentsDirectory()).path;
    final path = '$dir/consentForm.pdf';
    final file = File(path);
    _notifier.consentFormPDf = file.path;
    file.writeAsBytesSync(data);
  }
}
