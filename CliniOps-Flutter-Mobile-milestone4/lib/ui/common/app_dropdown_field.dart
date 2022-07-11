import 'package:clini_app/data/data.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AppDropDownFormField<T> extends StatefulWidget {
  final String name;
  final T? initalValue;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final ValueChanged<T?>? onSubmitted;
  final void Function(T?)? onChanged;
  final String? errorText;
  final String label;
  final bool enabled;
  final List<DropdownMenuItem<T>>? dropdownList;
  final bool autofocus;
  final Widget? child;

  const AppDropDownFormField({
    required this.label,
    required this.name,
    this.validator,
    this.keyboardType,
    this.onSubmitted,
    this.onChanged,
    this.errorText,
    this.enabled = true,
    this.autofocus = false,
    this.initalValue,
    this.child,
    this.dropdownList,
  });

  @override
  _AppDropDownFormFieldState<T> createState() =>
      _AppDropDownFormFieldState<T>();
}

class _AppDropDownFormFieldState<T> extends State<AppDropDownFormField<T>> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: AppText.text18w400Black.copyWith(fontSize: 16.sp)),
          sizedBoxWithHeight(10),
          FormBuilderDropdown<T>(
            name: widget.name,
            onChanged: widget.onChanged,

            enabled: widget.enabled,
            autofocus: widget.autofocus,
            // allowClear: true,

            initialValue: widget.initalValue,
            icon: const RotatedBox(
                quarterTurns: 3, child: Icon(Icons.arrow_back_ios_new)),
            iconSize: 14.r,
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
            items: widget.dropdownList ?? [],
            style: AppText.text22w400Black.copyWith(fontSize: 16.sp),
          ),
          sizedBoxWithHeight(16),
        ],
      ),
    );
  }
}
