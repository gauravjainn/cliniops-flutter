import 'package:clini_app/data/data.dart';
import 'package:clini_app/generated/l10n.dart';
import 'package:clini_app/routes/routes.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';

class MoreScreenView extends StatelessWidget {
  const MoreScreenView();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBoxWithHeight(16),
              _buildRow('', S.of(context).profile, _handleProfileTap),
              sizedBoxWithHeight(24),
              _buildRow(
                '',
                S.of(context).privacyPolicy,
                () => _handlePrivacyPolicy(context),
              ),
              sizedBoxWithHeight(24),
              _buildRow(
                '',
                S.of(context).termsOfServices,
                () => _handleTermsService(context),
              ),
              const Spacer(),
              Text(
                'App ${S.of(context).version}- v${AppEnvironment.packageInfo.version}',
                textAlign: TextAlign.center,
                style: AppText.text14w400Black.copyWith(color: AppColors.white),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -60.r,
          right: -60.r,
          child: GestureDetector(
            // onTap: () => _handleLogout(context),
            child: Stack(
              children: [
                CircleAvatar(backgroundColor: AppColors.white, radius: 70.r),
                Positioned(
                  top: 40.r,
                  left: 28.r,
                  child: Text(
                    'Logout',
                    style: AppText.text14w400Black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRow(String icon, String label, VoidCallback onClick) {
    return GestureDetector(
      onTap: onClick,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.mp_rounded,
            color: AppColors.white,
            size: 26.r,
          ),
          sizedBoxWithWidth(12),
          Text(
            label,
            style: AppText.text18w400White.copyWith(fontSize: 14.sp),
          )
        ],
      ),
    );
  }

  void _handleProfileTap() {
    AppEnvironment.navigator.pushNamed(
      GeneralRoutes.profileView,
    );
  }

  void _handlePrivacyPolicy(BuildContext context) {
    AppEnvironment.navigator.pushNamed(
      GeneralRoutes.webView,
      arguments: WebViewArgs(
        title: S.of(context).privacyPolicy,
        url: 'https://github.com/',
      ),
    );
  }

  void _handleTermsService(BuildContext context) {
    AppEnvironment.navigator.pushNamed(
      GeneralRoutes.webView,
      arguments: WebViewArgs(
        title: S.of(context).termsOfServices,
        url: 'https://github.com/',
      ),
    );
  }

  // void _handleLogout(BuildContext context) async {
  //   context.showLoadingIndicator();
  //   StudyNotifier _notifier = context.read<StudyNotifier>();
  //   AuthNotifier _usernotifier = context.read<AuthNotifier>();
  //   _notifier.clear();
  //   _notifier.clearData();
  //   _usernotifier.clear();
  //   await SecureStorage().removeAllPrefs();
  //   context.removeLoadingIndicator();
  //   AppEnvironment.navigator
  //       .pushNamedAndRemoveUntil(AuthRoutes.loginScreen, (route) => false);
  // }
}
