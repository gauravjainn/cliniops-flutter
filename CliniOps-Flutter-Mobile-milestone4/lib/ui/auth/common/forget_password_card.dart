import 'package:clini_app/controllers/controllers.dart';
import 'package:clini_app/data/data.dart';
import 'package:clini_app/generated/l10n.dart';
import 'package:clini_app/routes/routes.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class ForgotPasswordCard extends StatelessWidget {
  ForgotPasswordCard();

  final _formKey = GlobalKey<FormBuilderState>();
  final emailIdCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.all(5.w),
            child: IconButton(
              onPressed: () => AppEnvironment.navigator.pop(),
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: AppColors.greyPrimary,
                size: 24.r,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 48.h, horizontal: 16.w),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // sizedBoxWithHeight(64),
                Text(
                  S.of(context).forgotPassword,
                  style: AppText.text24w700White
                      .copyWith(color: AppColors.textBlack),
                ),
                sizedBoxWithHeight(32),
                Text(
                  S.of(context).enterEmail,
                  style: AppText.text20w300LightGrey,
                  textAlign: TextAlign.center,
                ),
                sizedBoxWithHeight(24),
                AppTextFormField(
                  label: S.of(context).emailId,
                  name: 'email_id',
                  controller: emailIdCtrl,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.email(context),
                  ]),
                ),
                sizedBoxWithHeight(24),
                AppButton(
                  onClick: () => _handleCta(context),
                  label: S.of(context).submit,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _handleCta(BuildContext context) async {
    final notifier = context.read<AuthNotifier>();

    if (_formKey.currentState!.saveAndValidate()) {
      context.showLoadingIndicator();
      final resp = await notifier.forgotPassword(emailId: emailIdCtrl.text);
      context.removeLoadingIndicator();

      
      if (resp.isSuccess) {
        context.showSnackBar(resp.message);
        await Future.delayed(const Duration(milliseconds: 1500));
        AppEnvironment.navigator.pushReplacementNamed(AuthRoutes.loginScreen);
      } else {
        context.showErrorSnackBar(resp.message);
      }
    }
  }
}
