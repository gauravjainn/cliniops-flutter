import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
// App colors   
  static const bluePrimary = Color(0xff208FFE);
  static const blueSecondary = Color(0xff03A9F4);
  static const blackPrimary = Color(0xff042D43);
  static const redOrangePrimary = Color(0xffF16E60);
  static const greyPrimary = Color(0xff707070);
  static const lavendarPrimary = Color(0xffdaedf5);
  static const white = Color(0xffffffff);
  static const appPrimary = Color(0xff12999E);
  static const dullWhite = Color(0xfff6f6f6);
  static const greyBGColor = Color(0xffEBEBEB);
  static const blueDark = Color(0xff3434FF);
  static const textGrey = Color(0xff535353);
  static const textLightGrey = Color(0xff727272);
  static const bgLightGrey = Color(0xffF6F6F6);
  static const textBlack = Color(0xff202021);
  static const navbarColor = Color(0xfff6f6f6);
  static const pillColorSelected = Color(0xff818181);
  static const greyGradientColor = Color(0xffC5C5C5);
  static const greyDarkGradientColor = Color(0xff9D9D9D);

  static final authBoxShadow = [
    BoxShadow(
      color: const Color(0xff000029).withOpacity(0.16),
      offset: const Offset(-1, 2),
      blurRadius: 12,
      spreadRadius: 12,
    ),
  ];
  static final normalBoxShadow = [
    BoxShadow(
      color: const Color(0xff000029).withOpacity(0.12),
      offset: const Offset(-1, 2),
      blurRadius: 2,
      spreadRadius: 2,
    ),
  ];
  static const greyButtonGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.greyGradientColor, AppColors.greyDarkGradientColor],
  );
}
