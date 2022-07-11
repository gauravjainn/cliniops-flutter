import 'package:clini_app/controllers/controllers.dart';
import 'package:clini_app/generated/l10n.dart';
import 'package:clini_app/routes/routes.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  final usernameController = TextEditingController(
    text: AppEnvironment.user?.profileDetails?.username,
  );

  final passController = TextEditingController();

  final passConfirmController = TextEditingController();

  final oldPassController = TextEditingController();
final newnotifier = ValueNotifier<bool>(true);
final confrimnotifier = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CliniAppBar(title: S.of(context).changePass),
      body: FormBuilder(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
          children: [
            AppTextFormField(
              label: S.of(context).username,
              name: 'Username',
              enabled: false,
              controller: usernameController,
              validator: FormBuilderValidators.required(context),
            ),
            sizedBoxWithHeight(16),
            AppTextFormField(
              label: 'Old Password',
              name: 'Old Password',
              controller: oldPassController,
              validator: FormBuilderValidators.required(context),
              obscureText: true,
            ),
            sizedBoxWithHeight(16),
            ValueListenableBuilder<bool>(
                  valueListenable: newnotifier,
                  builder: (context, value, child)  { 
                return AppTextFormField(
                  label: 'New ' + S.of(context).password,
                  name: 'password',
                  suffixIcon: IconButton(onPressed: () => {
                  newnotifier.value = !newnotifier.value 
                }, icon: Icon(value?  Icons.visibility_off:Icons.visibility),),
                obscureText: value,
                  controller: passController,
                  validator: FormBuilderValidators.required(context),
                );
              }
            ),
            sizedBoxWithHeight(16),
             sizedBoxWithHeight(16),
            ValueListenableBuilder<bool>(
                  valueListenable: confrimnotifier,
                  builder: (context, value, child)  { 
                return AppTextFormField(
                  label: 'Confirm Password',
                  name: 'confirm_password',
                  suffixIcon: IconButton(onPressed: () => {
                  confrimnotifier.value = !confrimnotifier.value 
                }, icon: Icon(value?  Icons.visibility_off:Icons.visibility),),
                obscureText: value,
                  controller: passConfirmController,
                  validator: FormBuilderValidators.required(context),
                );
              }
            ),
            sizedBoxWithHeight(56),
            AppButton(
              label: S.of(context).submit,
              onClick: () => _handleSubmit(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSubmit(BuildContext context) async {
    if (!_formKey.currentState!.saveAndValidate() ||
        !_isConfirmPasswordCorrect()) {
      return;
    }
    final _notifier = context.read<AuthNotifier>();

    context.showLoadingIndicator();
    final resp = await _notifier.changePassword(
      userId: AppEnvironment.user!.profileDetails!.subjectUserId!,
      oldPassword: oldPassController.text,
      newPassword: passConfirmController.text,
    );
    context.removeLoadingIndicator();
    if (resp.isSuccess) {
      context.showSnackBar(resp.message);
      AppEnvironment.navigator
          .pushNamedAndRemoveUntil(AuthRoutes.loginScreen, (route) => false);
    } else {
      context.showErrorSnackBar(resp.message);
    }
  }

  bool _isConfirmPasswordCorrect() {
    final isSame = passConfirmController.text == passController.text;
    if (!isSame) {
      _formKey.currentState!.invalidateField(
        name: 'confirm_password',
        errorText: 'New Password and confirm password should be same',
      );
      context.showErrorSnackBar(
          'New Password and confirm password should be same',
          actionTitle: 'Error');
    }
    return isSame;
  }
}
