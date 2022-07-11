import 'package:clini_app/data/data.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';

class CliniAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget?  endWidget;

  const CliniAppBar({required this.title,this.endWidget});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(12.r),
          ),
        ),
        
      backgroundColor: AppColors.appPrimary,
      actions: [endWidget??const SizedBox()],
      leading: IconButton(
        onPressed: () => AppEnvironment.navigator.pop(),
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.white,
          size: 18.r,
        ),
      ),
      title: Text(
        title,
        style: AppText.text20w700Green.copyWith(color: AppColors.white),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}





class AppbarWithWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  

  const AppbarWithWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(12.r),
          ),
        ),
        
      backgroundColor: AppColors.appPrimary,
      leading: IconButton(
        onPressed: () => AppEnvironment.navigator.pop(),
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.white,
          size: 18.r,
        ),
      ),
      title: Text(
        title,
        style: AppText.text20w700Green.copyWith(color: AppColors.white),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
