import 'dart:io';

import 'package:clini_app/controllers/controllers.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ConsentPdfViewer extends StatefulWidget {
  @override
  _ConsentPdfViewerState createState() => _ConsentPdfViewerState();
}

class _ConsentPdfViewerState extends State<ConsentPdfViewer> {
  late StudyNotifier _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = context.read<StudyNotifier>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CliniAppBar(
        title: 'Consent Form',
        endWidget: IconButton(
          onPressed: _handleSaveFile,
          icon: const Icon(Icons.download),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            Expanded(
              child: SfPdfViewer.file(
                File(_notifier.consentFormPDf!),
                onDocumentLoadFailed: (_) {
                  context.showSnackBar(
                    'PDF loading is failed .Please try again',
                    actionTitle: 'Error',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSaveFile() async {
    context.showLoadingIndicator();
    await context.savePdfDocumentToDocumentFolder(
      File(_notifier.consentFormPDf!).readAsBytesSync(),
      'consent_form',
    );
    context.removeLoadingIndicator();
  }
}
