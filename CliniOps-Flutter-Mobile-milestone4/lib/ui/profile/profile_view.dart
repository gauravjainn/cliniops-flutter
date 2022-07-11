import 'package:clini_app/data/data.dart';
import 'package:clini_app/generated/l10n.dart';
import 'package:clini_app/routes/routes.dart';
import 'package:clini_app/services/services.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/ui/auth/auth.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileView extends StatelessWidget {
  const ProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(context),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      children: [
        sizedBoxWithHeight(48),
        Text(
          S.of(context).yourInformation,
          style: AppText.text22w700Black
              .copyWith(fontSize: 18.sp, color: AppColors.blackPrimary),
        ),
        sizedBoxWithHeight(16),
        Table(
          columnWidths: const {0: FlexColumnWidth(), 1: FlexColumnWidth(1.5)},
          children: [
            getRow(
              'Username:',
              AppEnvironment.user?.profileDetails?.username ?? 'NA',
            ),
            getRow(
              'Subject ID:',
              AppEnvironment.user?.profileDetails?.subjectID ?? 'NA',
            ),
            getRow(
              'Email:',
              AppEnvironment.user?.profileDetails?.email ?? 'NA',
            ),
            getRow(
              'Registered by:',
              AppEnvironment.user?.profileDetails?.registeredBy ?? 'NA',
            ),
            getRow(
              'Registered on:',
              AppEnvironment.user?.profileDetails?.registeredDate != null
                  ? DateFormat('yyyy-MM-dd hh:mm:ss')
                      .parse(AppEnvironment.user!.profileDetails!.registeredDate
                          .toString())
                      .formatDate('MMM dd, yyyy, hh:mm a')
                  : '-',
            ),
            getRow(
              'Group:',
              AppEnvironment.user?.profileDetails?.group ?? 'NA',
            ),
            getRow(
              'Site:',
              AppEnvironment.user?.profileDetails?.site ?? 'NA',
            ),
          ],
        ),
        sizedBoxWithHeight(8),
        const Divider(color: AppColors.greyGradientColor),
        sizedBoxWithHeight(8),
        Column(
          children: [
            sizedBoxWithHeight(32),
            AppRoundedButton(
              text: 'Change Your Password',
              padding: EdgeInsets.symmetric(vertical: 12.h),
              onPressed: () => AppEnvironment.navigator
                  .pushNamed(GeneralRoutes.changePassView),
            ),
            sizedBoxWithHeight(8),
            AppRoundedButton(
              text: 'Log Out',
              padding: EdgeInsets.symmetric(vertical: 12.h),
              onPressed: () => _handleLogout(context),
            ),
            sizedBoxWithHeight(48),
            Image(
              image: const AssetImage(Images.customerLogoIconPath),
              height: 65.h,
              width: 120.w,
            )
          ],
        ),
        const AppVersion()
      ],
    );
  }

  TableRow getRow(String key, String value) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Text(
            key,
            style: AppText.text16w400Grey,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Text(
            value,
            style: AppText.text14w400Black.copyWith(fontSize: 16.sp),
          ),
        ),
      ],
    );
  }

  void _handleLogout(BuildContext context) async {
    context.showLoadingIndicator();
    await SecureStorage().removeAllPrefs();
    context.removeLoadingIndicator();
    AppEnvironment.navigator
        .pushNamedAndRemoveUntil(AuthRoutes.loginScreen, (route) => false);
  }
}
