import 'package:clini_app/data/data.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String? label;
  final VoidCallback? onClick;
  final Widget? icon;
  final int radius;
  final Color? primaryColor;
  final int horizontalMargin;
  final int horizontalPadding;
  final int verticalPadding;
  final int? width;
  final int? height;
  final TextStyle? textStyle;
  final Color? highLightedTextColor;
  final bool isDisabled;
  final Alignment alignment;
  final Alignment iconAlign;
  final Alignment textAlign;
  final int textPadding;
  final EdgeInsets? textInsetPadding;
  final TextAlign labelAlign;
  final BoxConstraints? constraints;
  final bool shrinkWrap;
  final onHighLightChange = ValueNotifier(false);

  AppButton({
    this.label,
    required this.onClick,
    this.icon,
    this.radius = 11,
    this.primaryColor,
    this.horizontalMargin = 18,
    this.horizontalPadding = 8,
    this.verticalPadding = 12,
    this.width,
    this.height,
    this.textStyle,
    this.highLightedTextColor,
    this.isDisabled = false,
    this.alignment = Alignment.center,
    this.iconAlign = Alignment.centerLeft,
    this.textAlign = Alignment.center,
    this.textPadding = 0,
    this.textInsetPadding,
    this.labelAlign = TextAlign.center,
    this.constraints,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    return _renderButton();
  }

  Widget _renderButton() {
    return Align(
      alignment: alignment,
      child: AnimatedContainer(
        duration: animDuration,
        width: width?.w,
        height: height?.h,
        constraints: constraints,
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin.w,vertical: 8.h),
        decoration: BoxDecoration(
          color: primaryColor ?? _getColor(),
          borderRadius: BorderRadius.circular(radius.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: _renderSplashButton(),
      ),
    );
  }

  Widget _renderSplashButton() {
    final button = Stack(
      alignment: textAlign,
      children: [
        if (icon != null) ...[
          Align(
            alignment: iconAlign,
            child: icon!,
          ),
        ],
        if (label?.isNotEmpty ?? false) ...{
          Padding(
            padding: textInsetPadding ??
                EdgeInsets.symmetric(horizontal: textPadding.w),
            child: _renderButtonText(),
          ),
        },
      ],
    );
    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: InkWell(
        onTap: isDisabled ? null : onClick,
        highlightColor: primaryColor != null
            ? primaryColor!.withOpacity(0.3)
            : AppColors.appPrimary,
        onHighlightChanged: (val) => onHighLightChange.value = val,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding.h,
            horizontal: horizontalPadding.w,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (shrinkWrap) ...{
                Flexible(child: button)
              } else ...{
                Expanded(child: button)
              },
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderButtonText() {
    return ValueListenableBuilder(
      valueListenable: onHighLightChange,
      builder: (_, bool isHighlighted, __) {
        return Text(
          label!,
          textAlign: labelAlign,
          style: textStyle?.copyWith(
                color: isHighlighted
                    ? highLightedTextColor ?? AppColors.white
                    : textStyle?.color,
              ) ??
              AppText.text18w400White,
        );
      },
    );
  }

  Color _getColor() {
    return (isDisabled || onClick == null)
        // TODO: add disabled color
        ? AppColors.greyBGColor
        : AppColors.appPrimary;
  }
}
