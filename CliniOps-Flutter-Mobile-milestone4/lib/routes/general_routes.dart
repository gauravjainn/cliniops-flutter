part of 'routes.dart';

class GeneralRoutes {
  /// leading string for general routes, this needs to be used when creating
  /// new route
  static const generalLeading = '/general-route';

  static const navbar = generalLeading + '/navbar';
  static const profileView = generalLeading + '/profile';
  static const changePassView = generalLeading + '/changePass';
  static const webView = generalLeading + '/webview';
  static const painEvaluation = generalLeading + '/pain-evaluation';
  static const languageSelection = generalLeading + '/language-selection';
  static const pdfViewer = generalLeading + '/pdf_viewer';

  static final generalRoutes = <String>{
    navbar,
    profileView,
    changePassView,
    webView,
    painEvaluation,
    languageSelection,
    pdfViewer
  };

  static Widget getPage(String currentRoute, Object? args) {
    Widget child;
    switch (currentRoute) {
      case GeneralRoutes.navbar:
        child = Navbar();
        break;
      case GeneralRoutes.profileView:
        child = const ProfileView();
        break;
      case GeneralRoutes.changePassView:
        child = ChangePasswordScreen();
        break;
      case GeneralRoutes.webView:
        if (CommonUtils.hasInvalidArgs<WebViewArgs>(args!)) {
          child = CommonUtils.misTypedArgsRoute<WebViewArgs>(args);
        } else {
          child = AppWebView(args as WebViewArgs);
        }
        break;
      case GeneralRoutes.painEvaluation:
        if (CommonUtils.hasInvalidArgs<PainEvaluationArgs>(args!)) {
          child = CommonUtils.misTypedArgsRoute<PainEvaluationArgs>(args);
        } else {
          child = PainEvalutionScreen(args as PainEvaluationArgs);
        }
        break;
      case GeneralRoutes.pdfViewer:
        if (CommonUtils.hasInvalidArgs<PdfViewerArgs>(args!)) {
          child = CommonUtils.misTypedArgsRoute<PdfViewerArgs>(args);
        } else {
          child = PdfViewer(args as PdfViewerArgs);
        }
        break;
      
      case GeneralRoutes.languageSelection:
        child = const LanguageSelectionScreen();
        break;
      default:
        child = PageNotFound();
    }
    return child;
  }
}
