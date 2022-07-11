import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';

class ActivityListViewItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final VoidCallback onPressed;

  const ActivityListViewItem({
    required this.title,
    required this.subtitle,
    required this.onPressed,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 7.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Image(image: AssetImage(image), height: 24.r),
            ),
            sizedBoxWithWidth(8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppText.text18w400Black),
                  sizedBoxWithHeight(4),
                  Text('Modified : $subtitle', style: AppText.text18w400Grey.copyWith(fontSize: 15.sp))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
