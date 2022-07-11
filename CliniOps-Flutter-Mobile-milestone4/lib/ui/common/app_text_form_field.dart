import 'package:clini_app/data/data.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AppTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String name;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String?>? onSubmitted;
  final ValueChanged<String?>? onChanged;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final String label;
  final bool enabled;
  final Widget? suffixIcon;
  final bool autofocus;
  final bool readOnly;
  final bool obscureText;
  final String? initialValue;

  const AppTextFormField({
    required this.label,
    required this.name,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.suffixIcon,
    this.onSubmitted,
    this.onChanged,
    this.errorText,
    this.inputFormatters,
    this.enabled = true,
    this.autofocus = false,
    this.readOnly = false,
    this.obscureText = false,
    this.initialValue,
  });

  @override
  _AppTextFormFieldState createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: AppText.text18w400Black),
          sizedBoxWithHeight(8),
          FormBuilderTextField(
            name: widget.name,
            controller: widget.controller,
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onSubmitted: widget.onSubmitted,
            onChanged: widget.onChanged,
            inputFormatters: widget.inputFormatters,
            enabled: widget.enabled,
            autofocus: widget.autofocus,
            readOnly: widget.readOnly,
            obscuringCharacter: '*',
            obscureText: widget.obscureText,
            initialValue: widget.initialValue,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.r),
                borderSide: BorderSide(color: AppColors.blueDark, width: 1.r),
              ),
              suffix: widget.suffixIcon ?? const SizedBox(width: 0,),
              errorStyle: AppText.text12w400Grey.copyWith(color: Colors.red),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.r),
                borderSide: BorderSide(color: AppColors.blueDark, width: 1.r),
              ),
            ),
            style: AppText.text22w400LightGrey.copyWith(fontSize: 20.sp),
          ),
        ],
      ),
    );
  }
}
