import 'package:clini_app/data/data.dart';
import 'package:clini_app/generated/l10n.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ConsentSuccessScreen extends StatelessWidget {
  final VoidCallback onTap;

  const ConsentSuccessScreen({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage(Images.successIcon),
          height: 92.r,
          width: 92.r,
        ),
        sizedBoxWithHeight(24),
        Text(S.of(context).success, style: AppText.text30w700Green),
        sizedBoxWithHeight(32),
        Text.rich(
          TextSpan(
            text: S.of(context).please,
            style: AppText.text18w300Grey,
            children: [
              TextSpan(
                text: S.of(context).clickHere,
                style: AppText.text20w400Green,
                recognizer: TapGestureRecognizer()..onTap = onTap,
              ),
              TextSpan(text: S.of(context).remainingSuccessMessage),
            ],
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
