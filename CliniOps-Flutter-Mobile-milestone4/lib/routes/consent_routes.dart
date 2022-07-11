part of 'routes.dart';

//Consent Screens routes routes
class ConsentRoutes {
  /// leading string for routes in Consent Screens routes, this needs to be used when creating
  /// new route
  static const consentLeading = '/consent-route';

  static const consentScreen = consentLeading + '/consent-screen';
  static const consentPreviewScreen = consentLeading + '/consent-preview';

  static final consentRoutes = <String>{consentScreen};

  static Widget getPage(String currentRoute, Object? args) {
    Widget child;
    switch (currentRoute) {
      case ConsentRoutes.consentScreen:
        if (CommonUtils.hasInvalidArgs<ConsentScreenArgs>(args!)) {
          child = CommonUtils.misTypedArgsRoute<ConsentScreenArgs>(args);
        } else {
          child = ConsentScreen(args as ConsentScreenArgs);
        }

        break;
      case ConsentRoutes.consentPreviewScreen:
        child = ConsentPdfViewer();
        break;
      default:
        child = PageNotFound();
    }
    return child;
  }
}
