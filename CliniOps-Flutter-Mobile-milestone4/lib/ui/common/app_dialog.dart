import 'package:clini_app/data/data.dart';
import 'package:clini_app/generated/l10n.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';

class AppDialog {
  AppDialog._();
  static void showInstructionDialog(BuildContext context, String data) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r)), //this right here
          child: SizedBox(
            height: 388.h,
            // width: 380.w,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 18.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage(Images.questionMark),
                    width: 42.w,
                    height: 42.h,
                  ),
                  sizedBoxWithHeight(12),
                  Text(
                    S.of(context).informations,
                    style: AppText.text20w400Black.copyWith(fontSize: 24.sp),
                  ),
                  sizedBoxWithHeight(20),
                  Text(
                    data,
                    style: AppText.text22w300LightGrey.copyWith(
                        fontSize: 16.sp,
                        wordSpacing: 2.sp,
                        letterSpacing: 1.sp),
                  ),
                  sizedBoxWithHeight(42),
                  AppButton(
                    onClick: () => {AppEnvironment.navigator.pop()},
                    label: S.of(context).okWithEx.toUpperCase(),
                    horizontalMargin: 42,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
