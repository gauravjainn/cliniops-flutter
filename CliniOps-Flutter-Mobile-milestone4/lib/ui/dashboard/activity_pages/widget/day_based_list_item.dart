import 'package:clini_app/data/data.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';

class DayBasedListItem extends StatelessWidget {
  final String label;
  final List<ItemsType> list;
  final ValueChanged<ItemsType> onTap;

  const DayBasedListItem({
    required this.label,
    required this.list,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        sizedBoxWithHeight(14),
        _getLinedText(label),
        sizedBoxWithHeight(12),
        Wrap(
          children: list
              .map((e) => GestureDetector(
                    onTap: () => onTap(e),
                    child: ListViewSubItem(e),
                  ))
              .toList(),
        )
      ],
    );
  }

  Widget _getLinedText(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            indent: 64.w,
            endIndent: 12.w,
            color: AppColors.greyGradientColor,
            thickness: 2.h,
          ),
        ),
        Text(
          title,
          style: AppText.text18w400Grey
              .copyWith(fontSize: 14.sp, color: AppColors.greyGradientColor),
        ),
        Expanded(
          child: Divider(
            indent: 12.w,
            endIndent: 64.w,
            color: AppColors.greyGradientColor,
            thickness: 2.h,
          ),
        ),
      ],
    );
  }
}

class ListViewSubItem extends StatelessWidget {
  final ItemsType item;
  const ListViewSubItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: AppColors.normalBoxShadow,
        border: Border(
          right: BorderSide(color: AppColors.appPrimary, width: 4.w),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: AssetImage(
              getCheckBox(
                item.isCompleted
                    ? CheckBoxType.CHECKED
                    : CheckBoxType.UN_CHECKED,
              ),
            ),
            height: 24.h,
            width: 24.h,
          ),
          sizedBoxWithWidth(8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    item.label,
                    style: AppText.text18w400Grey,
                  ),
                ),
                if (item.subLabel != null) ...[
                  sizedBoxWithHeight(4),
                  Text(
                    item.subLabel ?? '',
                    style: AppText.text18w400Grey.copyWith(fontSize: 16.sp),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getCheckBox(CheckBoxType label) {
    switch (label) {
      case CheckBoxType.CHECKED:
        return Images.successIcon;
      case CheckBoxType.UN_CHECKED:
        return Images.uncheckGreyIconPath;
      default:
        return Images.uncheckGreyIconPath;
    }
  }
}

class ItemsType {
  String label;
  String? subLabel;
  StudyConfigurationFormModel data;
  int visitId;
  bool isCompleted;

  ItemsType({
    required this.label,
    required this.data,
    required this.visitId,
    required this.isCompleted,
    this.subLabel,
  });
}
