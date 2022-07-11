import 'package:clini_app/controllers/controllers.dart';
import 'package:clini_app/data/data.dart';
import 'package:clini_app/generated/l10n.dart';
import 'package:clini_app/routes/routes.dart';
import 'package:clini_app/themes/app_text.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class LoginCard extends StatefulWidget {
  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _handleUserNameChange(context, ''));
  }

  final _formKey = GlobalKey<FormBuilderState>();

  final usernameController = TextEditingController();

  final passController = TextEditingController();

  final notifier = ValueNotifier(true);

  final imageNotifier = ValueNotifier(Images.appLogoIconPath);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer<AuthNotifier>(
            builder: (_, val, __) {
              Widget child = Image(
                image: const AssetImage(Images.appLogoIconPath),
                height: 32.h,
                width: 182.w,
              );

              return val.bytes == null
                  ? child
                  : Image.memory(
                      val.bytes!,
                      height: 120.h,
                    );
            },
          ),
          sizedBoxWithHeight(24),
          AppTextFormField(
            label: S.of(context).username,
            name: 'Username',
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z]'))
            ],
            onChanged: (val) => _handleUserNameChange(context, val),
            controller: usernameController,
            validator: FormBuilderValidators.required(context),
          ),
          sizedBoxWithHeight(16),
          ValueListenableBuilder<bool>(
            valueListenable: notifier,
            builder: (context, value, child) {
              return ValueListenableBuilder(
                valueListenable: passController,
                builder: (context, TextEditingValue text, __) {
                  return AppTextFormField(
                    label: S.of(context).password,
                    name: 'Password',
                    suffixIcon: text.text.isNotEmpty
                        ? IconButton(
                            onPressed: () => {notifier.value = !notifier.value},
                            icon: Icon(
                              value ? Icons.visibility_off : Icons.visibility,
                            ),
                          )
                        : null,
                    obscureText: value,
                    controller: passController,
                    validator: FormBuilderValidators.required(context),
                  );
                },
              );
            },
          ),
          sizedBoxWithHeight(16),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: InkWell(
                onTap: () => AppEnvironment.navigator.pushNamed(
                  AuthRoutes.forgotPassword,
                ),
                child: Text(
                  S.of(context).forgotPassword,
                  style: AppText.text18w400BlueDark,
                ),
              ),
            ),
          ),
          sizedBoxWithHeight(24),
          AppButton(
            onClick: () => _handleCta(context),
            label: S.of(context).login,
          ),
        ],
      ),
    );
  }

  void _handleCta(BuildContext context) async {
    if (_formKey.currentState!.saveAndValidate()) {
      final notifier = context.read<AuthNotifier>();
      context.showLoadingIndicator();
      var _usernotifier = context.read<AuthNotifier>();
      // if user change the login details
      if (AppEnvironment.user != null &&
          AppEnvironment.user?.profileDetails?.username !=
              usernameController.text) {
        var _notifier = context.read<StudyNotifier>();
        var _usernotifier = context.read<AuthNotifier>();
        _notifier.clearData();
        _usernotifier.clearData();
      }
      if (_usernotifier.password == passController.text.trim() &&
          AppEnvironment.user?.profileDetails?.username ==
              usernameController.text) {
        context.removeLoadingIndicator();
        AppEnvironment.navigator.pushReplacementNamed(GeneralRoutes.navbar);
        return;
      }
      final resp = await notifier.login(
        email: usernameController.text,
        password: passController.text,
      );

      context.removeLoadingIndicator();

      Logger.logMsg(this, resp.toString());

      if (resp.isSuccess) {
        _usernotifier.password = passController.text;
        CommonUtils.logEvent(
          AppEvents.user_login,
          data: {'username': usernameController.text},
        );

        AppEnvironment.navigator
            .pushReplacementNamed(GeneralRoutes.languageSelection);
        // TODO: handle Success navigation to dashboard screen
        context.showSnackBar(resp.message, actionTitle: 'Success');
      } else {
        context.showErrorSnackBar(resp.message, actionTitle: 'Error');
      }
    }
  }

  void _handleUserNameChange(BuildContext context, String? value) async {}
}
