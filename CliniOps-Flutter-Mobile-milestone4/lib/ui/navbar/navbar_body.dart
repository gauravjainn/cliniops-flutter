import 'package:clini_app/data/data.dart';
import 'package:clini_app/generated/l10n.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/ui/chat/chat_screen.dart';
import 'package:clini_app/ui/dashboard/dashboard.dart';
import 'package:clini_app/ui/dashboard/document/document_view.dart';
import 'package:clini_app/ui/navbar/navbar.dart';
import 'package:clini_app/ui/profile/profile_view.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  final _bodyList = [
    DashboardScreen(),
    // DashboardScreen(),
    const ChatScreen(),
    const DocumentView(),
    const ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.appPrimary,
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 56.h,
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(12.r),
          ),
        ),
        title: Text(
          _getTitleString(_selectedIndex),
          style: AppText.text24w700White,
        ),
        actions: [
          if (_selectedIndex == 3) ...{const LanguageChangeNavBar()}
        ],
      ),
       
      bottomNavigationBar: _bottomNavigationBar(),
      body: _bodyList[_selectedIndex],
    );
  }

  String _getTitleString(int index) {
    switch (index) {
      case 0:
        return S.of(context).activities;
      case 1:
        return S.of(context).messages;
      case 2:
        return S.of(context).documents;
      case 3:
        return S.of(context).profile;
      default:
        return '';
    }
  }

  Widget _bottomNavigationBar() {
    return AnimatedContainer(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      decoration: const BoxDecoration(
        color: AppColors.navbarColor,
        boxShadow: [
          BoxShadow(
            color: Color(0x40dadada),
            offset: Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 8,
          ),
        ],
      ),
      duration: animDuration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _getNavItem(
            index: 0,
            selectedImage: Images.calenderLightBlueIconPath,
            unselectedImage: Images.calenderDarkBlueIconPath,
            text: S.of(context).activities,
          ),
          _getNavItem(
            index: 1,
            selectedImage: Images.messageLightIconPath,
            unselectedImage: Images.messageDarkIconPath,
            text: S.of(context).messages,
          ),
          _getNavItem(
            index: 2,
            selectedImage: Images.documentLightIconPath,
            unselectedImage: Images.documentDarkIconPath,
            text: S.of(context).documents,
          ),
          _getNavItem(
            index: 3,
            selectedImage: Images.profileLightIconPath,
            unselectedImage: Images.profileDarkIconPath,
            text: S.of(context).profile,
          ),
        ],
      ),
    );
  }

  Widget _getNavItem({
    required int index,
    required String selectedImage,
    required String unselectedImage,
    required String text,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: AnimatedCrossFade(
            firstChild: Image(
              image: AssetImage(selectedImage),
              color: _getColor(index),
              height: 25.r,
            ),
            secondChild: Image(
              image: AssetImage(unselectedImage),
              color: _getColor(index),
              height: 25.r,
            ),
            crossFadeState: _selectedIndex == index
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: animDuration,
          ),
          onPressed: () {
            // if (index == 3) {
            //   _modalBottomSheetMenu();
            // } else {
            setState(() => _selectedIndex = index);
            // }
          },
        ),
        Text(
          text,
          style: AppText.text12w400Grey.copyWith(color: _getColor(index)),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Color _getColor(int index) {
    if (_selectedIndex == index) {
      return AppColors.appPrimary;
    } else {
      return AppColors.greyPrimary;
    }
  }
}
