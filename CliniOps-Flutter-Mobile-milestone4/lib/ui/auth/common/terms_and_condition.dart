import 'package:clini_app/generated/l10n.dart';
import 'package:clini_app/routes/routes.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition();

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: S.of(context).byContinueYouAgree,
        style: AppText.text18w300Grey,
        children: [
          TextSpan(
            text: S.of(context).termsOfServices,
            style: AppText.text18w400BlueDark,
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                // TODO: add original t&c
                AppEnvironment.navigator.pushNamed(
                  GeneralRoutes.webView,
                  arguments: WebViewArgs(
                    title: S.of(context).termsOfServices,
                    url: 'https://github.com/',
                  ),
                );
              },
          ),
          TextSpan(text: S.of(context).andWithSpace),
          TextSpan(
            text: S.of(context).privacyPolicy,
            style: AppText.text18w400BlueDark,
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                // TODO: add original privacy policy

                AppEnvironment.navigator.pushNamed(
                  GeneralRoutes.webView,
                  arguments: WebViewArgs(
                    title: S.of(context).privacyPolicy,
                    url: 'https://github.com/',
                  ),
                );
              },
          ),
          const TextSpan(text: '.'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
