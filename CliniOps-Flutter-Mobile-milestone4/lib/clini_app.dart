import 'package:clini_app/controllers/controllers.dart';
import 'package:clini_app/controllers/document/document_notifier.dart';
import 'package:clini_app/data/data.dart';
import 'package:clini_app/generated/l10n.dart';
import 'package:clini_app/repositories/repositories.dart';
import 'package:clini_app/routes/routes.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class CliniApp extends StatefulWidget {
  const CliniApp();

  @override
  _CliniAppState createState() => _CliniAppState();
}

class _CliniAppState extends State<CliniApp> {
  final getIt = GetIt.I;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    _registerRepos();
    _registerNotifiers();
  }

  void _registerRepos() {
    getIt.registerSingleton<AuthRepo>(AuthRepo());
    getIt.registerSingleton<StudyRepo>(StudyRepo());
  }

  void _registerNotifiers() {
    getIt.registerSingleton(AppNotifier());
    getIt.registerSingletonAsync(
      () => AuthNotifier.initialize(getIt<AuthRepo>()),
    );
    getIt.registerSingletonAsync(
      () => StudyNotifier.initialize(getIt<StudyRepo>()),
    );
    getIt.registerSingletonAsync(
      () => DocumentNotifier.initialize(getIt<StudyRepo>()),
    );
    getIt.registerSingletonAsync(
      () => ChatNotifier.initialize(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var analytics = FirebaseAnalytics();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<AppNotifier>()),
        ChangeNotifierProvider(create: (_) => getIt<AuthNotifier>()),
        ChangeNotifierProvider(create: (_) => getIt<StudyNotifier>()),
        ChangeNotifierProvider(create: (_) => getIt<DocumentNotifier>()),
        ChangeNotifierProvider(create: (_) => getIt<ChatNotifier>()),
      ],
      child: Consumer<AppNotifier>(
        builder: (_, model, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            color: AppColors.appPrimary,
            theme: ThemeData(
              fontFamily: 'Lato',
              scaffoldBackgroundColor: AppColors.white,
            ),
            localizationsDelegates: const [
              S.delegate,
              FormBuilderLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: model.deviceLanguage,
            supportedLocales: appLocale.map.keys,
            onGenerateRoute: Routes.onGenerateRoute,
            navigatorKey: AppEnvironment.rootNavigationKey,
            navigatorObservers: [
              AppEnvironment.routeObserver,
              FirebaseAnalyticsObserver(analytics: analytics)
            ],
          );
        },
      ),
    );
  }
}
