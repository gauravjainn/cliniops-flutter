import 'dart:io';

import 'package:clini_app/data/data.dart';
import 'package:clini_app/ui/auth/auth.dart';
import 'package:clini_app/ui/change_password/change_password.dart';
import 'package:clini_app/ui/common/common.dart';
import 'package:clini_app/ui/consent/consent.dart';
import 'package:clini_app/ui/consent/consent_pdf_review.dart';
import 'package:clini_app/ui/dashboard/document/pdf_viewer.dart';
import 'package:clini_app/ui/language_selection/language_selection.dart';
import 'package:clini_app/ui/navbar/navbar.dart';
import 'package:clini_app/ui/page_not_found/page_not_found.dart';
import 'package:clini_app/ui/pain_evaluation/pain_evaluation.dart';
import 'package:clini_app/ui/profile/profile_view.dart';
import 'package:clini_app/ui/splash/splash_screen.dart';
import 'package:clini_app/ui/study/study_screen.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';

part 'auth_routes.dart';
part 'consent_routes.dart';
part 'general_routes.dart';
part 'route_arguments.dart';
part 'study_routes.dart';

class Routes {
  static String currentRoute = '/';
  static const splash = '/';

  static final routes = <String>{
    splash,
    ...AuthRoutes.authRoutes,
    ...GeneralRoutes.generalRoutes,
    ...ConsentRoutes.consentRoutes,
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    currentRoute = settings.name ?? '/';
    Widget child;
    if (currentRoute.startsWith(AuthRoutes.authLeading)) {
      child = AuthRoutes.getPage(currentRoute, args);
    } else if (currentRoute.startsWith(GeneralRoutes.generalLeading)) {
      child = GeneralRoutes.getPage(currentRoute, args);
    } else if (currentRoute.startsWith(ConsentRoutes.consentLeading)) {
      child = ConsentRoutes.getPage(currentRoute, args);
    } else if (currentRoute.startsWith(StudyRoutes.studyLeading)) {
      child = StudyRoutes.getPage(currentRoute, args);
    } else if (currentRoute == Routes.splash) {
      child = SplashScreen();
    } else {
      child = PageNotFound();
    }

    return MaterialPageRoute(
      builder: (_) => child,
      settings: settings,
    );
  }
}
