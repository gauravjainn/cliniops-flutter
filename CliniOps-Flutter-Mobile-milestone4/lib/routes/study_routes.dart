part of 'routes.dart';

//study routes

class StudyRoutes {
  /// leading string for routes in auth, this needs to be used when creating
  /// new route
  static const studyLeading = '/study-route';

  static const studyScreen = studyLeading + '/study-screen';

  static final studyRoutes = <String>{studyScreen};

  static Widget getPage(String currentRoute, Object? args) {
    Widget child;
    switch (currentRoute) {
      case StudyRoutes.studyScreen:
        if (CommonUtils.hasInvalidArgs<StudyScreenArgs>(args!)) {
          child = CommonUtils.misTypedArgsRoute<StudyScreenArgs>(args);
        } else {
          child = StudyScreen(args as StudyScreenArgs);
        }

        break;
      default:
        child = PageNotFound();
    }
    return child;
  }
}
