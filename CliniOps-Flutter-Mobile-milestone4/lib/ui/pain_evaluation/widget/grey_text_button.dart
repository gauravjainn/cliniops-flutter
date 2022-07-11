import 'package:clini_app/data/data.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';

class GreyButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final bool isQuestionMark;
  final EdgeInsets? padding;
  final double? width;

  const GreyButton({
    required this.child,
    required this.onPressed,
    this.isQuestionMark = false,
    this.width,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Container(
            width: width ?? 100.w,
            // height: 29.h,
            // margin: EdgeInsets.all(2.sp),
            padding: padding ?? EdgeInsets.all(4.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              gradient: AppColors.greyButtonGradient,
            ),
            child: Center(child: child),
          ),
          sizedBoxWithWidth(4),
          isQuestionMark
              ? Image(
                  image: const AssetImage(Images.questionMark),
                  height: 15.h,
                  width: 15.w,
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
