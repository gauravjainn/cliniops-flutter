import 'package:clini_app/data/data.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_html/flutter_html.dart';

class AppRadioFormField<T> extends StatefulWidget {
  final String name;
  final T? initalValue;
  final FormFieldValidator<T>? validator;
  final TextInputType? keyboardType;
  final ValueChanged<T?>? onSubmitted;
  final void Function(T?)? onChanged;
  final String? errorText;
  final String label;
  final bool enabled;
  final bool autofocus;
  final Widget? child;
  final List<FormBuilderFieldOption<T>> options;

  const AppRadioFormField({
    required this.label,
    required this.name,
    required this.options,
    this.validator,
    this.keyboardType,
    this.onSubmitted,
    this.onChanged,
    this.errorText,
    this.enabled = true,
    this.autofocus = false,
    this.initalValue,
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  _AppRadioFormFieldState<T> createState() => _AppRadioFormFieldState<T>();
}

class _AppRadioFormFieldState<T> extends State<AppRadioFormField<T>> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Html(data: widget.label),
          sizedBoxWithHeight(10),
          FormBuilderRadioGroup<T>(
            key: widget.key,
            name: widget.name,
            onChanged: widget.onChanged,
            enabled: widget.enabled,
            validator: widget.validator,
            initialValue: widget.initalValue,
            decoration: InputDecoration(
              // labelText: widget.name,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.r),
                borderSide: BorderSide(color: AppColors.blueDark, width: 1.r),
              ),
              errorStyle: AppText.text12w400Grey.copyWith(color: Colors.red),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.r),
                borderSide: BorderSide(color: AppColors.blueDark, width: 1.r),
              ),
            ),
            options: widget.options,
          ),
          sizedBoxWithHeight(16),
        ],
      ),
    );
  }
}
