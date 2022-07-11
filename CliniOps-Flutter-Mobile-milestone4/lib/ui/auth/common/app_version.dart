import 'package:clini_app/data/data.dart';
import 'package:clini_app/generated/l10n.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';

class AppVersion extends StatelessWidget {
  const AppVersion();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image(
                image: const AssetImage(Images.poweredIcon),
                height: 22.h,
              ),
              Image(
                image: const AssetImage(Images.logoIcon),
                height: 28.h,
              )
            ],
          ),
          Text(
            '${S.of(context).version} ${AppEnvironment.packageInfo.version}',
            textAlign: TextAlign.center,
            style: AppText.text16w400Grey,
          ),
        ],
      ),
    );
  }
}
