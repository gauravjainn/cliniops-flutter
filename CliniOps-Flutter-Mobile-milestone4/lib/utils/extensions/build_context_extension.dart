import 'dart:io';

import 'package:clini_app/data/data.dart';
import 'package:clini_app/generated/l10n.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

extension BuildContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  double get inset => MediaQuery.of(this).viewInsets.bottom;

  void showSnackBar(
    String msg, {
    String? actionTitle = '',
    VoidCallback? onActionCallback,
  }) {
    // TODO: add colors and text styles based on new designs

    // TODO: refactor this for action based toast
    // currently showing snackbar not implementing bottom sheet as of now

    SnackBarAction? snackBarAction;

    if (actionTitle != null || onActionCallback != null) {
      snackBarAction = SnackBarAction(
          label: actionTitle ?? '', onPressed: onActionCallback ?? () {});
    }
    if (actionTitle?.isNotEmpty ?? false) {
      var snackBar = SnackBar(
        content: Text(
          msg,
          // TODO: add toast style
          // style: AppText.textCustom(AppText.text16w600Title, msgColor),
        ),
        action: snackBarAction,
      );

      ScaffoldMessenger.of(this).showSnackBar(snackBar);
    } else {
      Fluttertoast.cancel();

      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: const Color(0xff898989),
      );
    }
  }

  void showErrorSnackBar(
    String msg, {
    String? actionTitle = '',
    VoidCallback? onActionCallback,
  }) =>
      showSnackBar(
        msg,
        actionTitle: actionTitle,
        onActionCallback: onActionCallback,
      );

  /// shows alert dialog with circular progressbar along with given text
  void showLoadingIndicator({
    String? text,
    bool isBarrierDismissible = false,
  }) {
    showDialog(
      context: this,
      barrierDismissible: isBarrierDismissible,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.h)),
            content: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const CircularProgressIndicator(
                    // color: AppColors.buttonColor
                    ),
                sizedBoxWithWidth(16),
                Expanded(
                  child: Text(
                    text ?? 'Loading ... ',
                    style: AppText.text14w400Black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// hides processing
  void removeLoadingIndicator() {
    if (AppEnvironment.navigator.canPop()) {
      AppEnvironment.navigator.pop();
    }
  }

  void showAlertDialog({
    bool isBarrierDismissible = false,
    String? title,
    String positiveText = 'Yes',
    String negativeText = 'No',
    VoidCallback? onPositiveTap,
    VoidCallback? onNegativeTap,
  }) {
    showDialog(
      context: this,
      barrierDismissible: isBarrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.h)),
          // TODO: add color
          // backgroundColor: AppColors.inputDefault,
          title: Text(
            title ?? S.of(context).sureClose,
            // TODO: add text style
            // style: AppText.text20NormalBody
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'YES',
                // TODO: add text style
                // style: AppText.text14NormalTitle,
              ),
              onPressed: onPositiveTap,
            ),
            TextButton(
              child: const Text(
                'NO',
                // TODO: add text style

                // style: AppText.text14NormalTitle
              ),
              onPressed: onNegativeTap ?? () => AppEnvironment.navigator.pop(),
            ),
          ],
        );
      },
    );
  }

  void showWidgetDialog(Widget child) {
    showDialog(
      context: this,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          child: child,
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        );
      },
    );
  }

  void copyClipboard(String msg) async {
    await Clipboard.setData(ClipboardData(text: msg)).whenComplete(() {
      showSnackBar('Code copied to clipboard');
    });
  }

  Future<Responser<File>> downloadFile(String url, String fileName) async {
    final httpClient = HttpClient();
    File file;
    var filePath = '';
    final appDocDir = await getApplicationDocumentsDirectory();
    final path = appDocDir.path;

    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        filePath = '$path/$fileName';
        file = File(filePath);
        await file.writeAsBytes(bytes);
        return Responser(message: 'Success', isSuccess: true, data: file);
      } else {
        return Responser(
          message: 'Error code: ' + response.statusCode.toString(),
          isSuccess: false,
        );
      }
    } catch (ex) {
      return Responser(message: ex.toString(), isSuccess: false);
    }
  }

  Future<void> savePdfDocumentToDocumentFolder(
      List<int> data, String title) async {

    try {
    
      var dir = '/storage/emulated/0/Download/';
      
      if (await Permission.storage.request().isGranted) {
  // Either the permission was already granted before or the user just granted it.
  if (Platform.isIOS) {
      final Directory  = await getApplicationSupportDirectory();
      // final String dirPath = Directory.path.toString().substring(0,20);
      // await Directory(dirPath).create(recursive: true);
      // final String filePath = '$dirPath/';

       //final path = await getApplicationDocumentsDirectory();
       // dir = path.path;
        dir = Directory.path;
      } else {
        await Directory(dir).create();
      }
      final path = dir +
          title +
          DateTime.now().microsecondsSinceEpoch.toString() +
          '.pdf';

      final file = File(path);

      file.writeAsBytesSync(data);
      // todo to save in gallery
      showSnackBar('Saved Successfully');
    }
}
      catch (e) {
      showErrorSnackBar(S.of(this).somethingWrong);
      Logger.logError(this, e);
    } 
  }
}
