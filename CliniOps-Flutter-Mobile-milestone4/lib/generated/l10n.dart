// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Clini`
  String get appName {
    return Intl.message(
      'Clini',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `No internet, please check your connection!`
  String get noInternet {
    return Intl.message(
      'No internet, please check your connection!',
      name: 'noInternet',
      desc: '',
      args: [],
    );
  }

  /// `You have been logged out of your account, please login again to continue`
  String get sessionExpired {
    return Intl.message(
      'You have been logged out of your account, please login again to continue',
      name: 'sessionExpired',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again later!`
  String get somethingWrong {
    return Intl.message(
      'Something went wrong. Please try again later!',
      name: 'somethingWrong',
      desc: '',
      args: [],
    );
  }

  /// `Server Error! Please try again later.`
  String get serverError {
    return Intl.message(
      'Server Error! Please try again later.',
      name: 'serverError',
      desc: '',
      args: [],
    );
  }

  /// `Sit back and relax\nWe're processing...`
  String get processing {
    return Intl.message(
      'Sit back and relax\nWe\'re processing...',
      name: 'processing',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to close this?`
  String get sureClose {
    return Intl.message(
      'Are you sure you want to close this?',
      name: 'sureClose',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `By continuing, you agree to our `
  String get byContinueYouAgree {
    return Intl.message(
      'By continuing, you agree to our ',
      name: 'byContinueYouAgree',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Services`
  String get termsOfServices {
    return Intl.message(
      'Terms of Services',
      name: 'termsOfServices',
      desc: '',
      args: [],
    );
  }

  /// ` and `
  String get andWithSpace {
    return Intl.message(
      ' and ',
      name: 'andWithSpace',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Activity`
  String get activities {
    return Intl.message(
      'Activity',
      name: 'activities',
      desc: '',
      args: [],
    );
  }

  /// `Messages`
  String get messages {
    return Intl.message(
      'Messages',
      name: 'messages',
      desc: '',
      args: [],
    );
  }

  /// `Documents`
  String get documents {
    return Intl.message(
      'Documents',
      name: 'documents',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `more`
  String get more {
    return Intl.message(
      'more',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Activity`
  String get activity {
    return Intl.message(
      'Activity',
      name: 'activity',
      desc: '',
      args: [],
    );
  }

  /// `List View`
  String get listView {
    return Intl.message(
      'List View',
      name: 'listView',
      desc: '',
      args: [],
    );
  }

  /// `Calendar View`
  String get calendarView {
    return Intl.message(
      'Calendar View',
      name: 'calendarView',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Email ID`
  String get emailId {
    return Intl.message(
      'Email ID',
      name: 'emailId',
      desc: '',
      args: [],
    );
  }

  /// `Pain Evaluation`
  String get painEvaluation {
    return Intl.message(
      'Pain Evaluation',
      name: 'painEvaluation',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Ok!`
  String get okWithEx {
    return Intl.message(
      'Ok!',
      name: 'okWithEx',
      desc: '',
      args: [],
    );
  }

  /// `Enter email address associated with your account.`
  String get enterEmail {
    return Intl.message(
      'Enter email address associated with your account.',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Informed Consent`
  String get informedConsent {
    return Intl.message(
      'Informed Consent',
      name: 'informedConsent',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get none {
    return Intl.message(
      'None',
      name: 'none',
      desc: '',
      args: [],
    );
  }

  /// `Tolerable`
  String get tolerable {
    return Intl.message(
      'Tolerable',
      name: 'tolerable',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Normal`
  String get normal {
    return Intl.message(
      'Normal',
      name: 'normal',
      desc: '',
      args: [],
    );
  }

  /// `Heavy`
  String get heavy {
    return Intl.message(
      'Heavy',
      name: 'heavy',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get informations {
    return Intl.message(
      'Information',
      name: 'informations',
      desc: '',
      args: [],
    );
  }

  /// `Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry"s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.`
  String get description {
    return Intl.message(
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry"s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Load Earlier Activities`
  String get loadEarlierActivity {
    return Intl.message(
      'Load Earlier Activities',
      name: 'loadEarlierActivity',
      desc: '',
      args: [],
    );
  }

  /// `YESTERDAY`
  String get yesterday {
    return Intl.message(
      'YESTERDAY',
      name: 'yesterday',
      desc: '',
      args: [],
    );
  }

  /// `Success!`
  String get success {
    return Intl.message(
      'Success!',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Please `
  String get please {
    return Intl.message(
      'Please ',
      name: 'please',
      desc: '',
      args: [],
    );
  }

  /// `Click here`
  String get clickHere {
    return Intl.message(
      'Click here',
      name: 'clickHere',
      desc: '',
      args: [],
    );
  }

  /// ` to view your Informed Consent.`
  String get remainingSuccessMessage {
    return Intl.message(
      ' to view your Informed Consent.',
      name: 'remainingSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Signature Pad`
  String get singaturePad {
    return Intl.message(
      'Signature Pad',
      name: 'singaturePad',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Email`
  String get invalidEmail {
    return Intl.message(
      'Invalid Email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueText {
    return Intl.message(
      'Continue',
      name: 'continueText',
      desc: '',
      args: [],
    );
  }

  /// `Your information`
  String get yourInformation {
    return Intl.message(
      'Your information',
      name: 'yourInformation',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePass {
    return Intl.message(
      'Change Password',
      name: 'changePass',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
