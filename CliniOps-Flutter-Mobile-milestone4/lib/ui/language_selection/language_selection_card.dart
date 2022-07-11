import 'package:clini_app/controllers/controllers.dart';
import 'package:clini_app/data/data.dart';
import 'package:clini_app/generated/l10n.dart';
import 'package:clini_app/routes/routes.dart';
import 'package:clini_app/services/services.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSelectionCard extends StatefulWidget {
  const LanguageSelectionCard();

  @override
  State<LanguageSelectionCard> createState() => _LanguageSelectionCardState();
}

class _LanguageSelectionCardState extends State<LanguageSelectionCard> {
  late StudyNotifier _studyNotifier;

  GlobalLanguageModel? selectedLanguage;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() {
    _studyNotifier = context.read<StudyNotifier>();
    selectedLanguage = _studyNotifier.currentLanguage;
    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => _getStudyFormConfiguration());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Consumer<AuthNotifier>(
          builder: (context, model, __) {
            if (model.bytes != null) {
              return Image.memory(
                model.bytes!,
                height: 120.h,
                fit: BoxFit.fitHeight,
              );
            }
            return Image(
              image: const AssetImage(Images.appLogoIconPath),
              height: 32.h,
              width: 182.w,
            );
          },
        ),
        sizedBoxWithHeight(80),
        Consumer<StudyNotifier>(
          builder: (_, model, __) {
            return AppDropDownFormField<GlobalLanguageModel>(
              label: S.of(context).selectLanguage,
              name: '',
              onChanged: (GlobalLanguageModel? val) => selectedLanguage = val!,
              initalValue: model.currentLanguage ??
                  GlobalLanguageModel(
                    locale: 'en',
                    languageId: 1,
                    languagename: 'English',
                  ),
              dropdownList: model
                  .getLanguageList()
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e.languagename.toString().capitalizeFirstOfEach,
                        ),
                      ))
                  .toList(),
            );
          },
        ),
        sizedBoxWithHeight(24),
        AppButton(
          onClick: () => _handleCta(),
          label: S.of(context).continueText,
        ),
      ],
    );
  }

  void _handleCta() {
    FirebaseAnalytics().setCurrentScreen(screenName: 'Language Screen');
    // TODO: handle language selection
    // _notifier.changeDeviceLanguage(appLocale.reverse[locale]!);
    _studyNotifier.setCurrentLanguage(
      selectedLanguage ??
          GlobalLanguageModel(
            locale: 'en',
            languageId: 1,
            languagename: 'English',
          ),
    );
    AppEnvironment.navigator.pushReplacementNamed(GeneralRoutes.navbar);
  }

  void _getStudyFormConfiguration() async {
    try {
      context.showLoadingIndicator();
      final resp = await _studyNotifier.getStudiesList();
      context.removeLoadingIndicator();

      if (!resp.isSuccess) {
        context.showErrorSnackBar(resp.message);
        if (resp.message.contains('session')) {
          await SecureStorage().removeAllPrefs();

          AppEnvironment.navigator.pushNamedAndRemoveUntil(
              AuthRoutes.loginScreen, (route) => false);
        }
        return;
      }

      final element = _studyNotifier.availableStudies.tryFirst;
      if (element?.id == null) {
        return;
      }
      context.showLoadingIndicator();

      final studyResp = await _studyNotifier.getStudyFormsConfiguration(
        studyId: element!.id!,
      );

      context.removeLoadingIndicator();

      if (!studyResp.isSuccess) {
        context.showErrorSnackBar(studyResp.message, actionTitle: 'Error');
        if (resp.message.contains('session')) {
          await SecureStorage().removeAllPrefs();

          AppEnvironment.navigator.pushNamedAndRemoveUntil(
              AuthRoutes.loginScreen, (route) => false);
        }
      }
    } catch (e) {
      Logger.logError(this, e);
    }
  }
}
