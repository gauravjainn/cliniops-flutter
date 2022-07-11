import 'package:clini_app/data/data.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';

class AppRoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final EdgeInsetsGeometry? padding;
  final Color bgColor;
  final Color borderColor;

  const AppRoundedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.padding,
    this.bgColor = AppColors.white,
    this.borderColor = AppColors.appPrimary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          padding ?? EdgeInsets.all(8.r),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(200.r),
            side: BorderSide(color: borderColor, width: 1.w),
          ),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          text,
          style: AppText.text16w400Grey.copyWith(color: borderColor),
        ),
      ),
    );
  }
}
