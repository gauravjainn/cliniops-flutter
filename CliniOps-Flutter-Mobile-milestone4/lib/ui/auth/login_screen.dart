import 'package:clini_app/data/data.dart';
import 'package:clini_app/ui/auth/auth.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lavendarPrimary,
      bottomNavigationBar: const AppVersion(),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          children: [
            sizedBoxWithHeight(64),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 48.h, horizontal: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppColors.white,
                boxShadow: AppColors.authBoxShadow,
              ),
              child: LoginCard(),
            ),
            sizedBoxWithHeight(48),
          ],
        ),
      ),
    );
  }
}
