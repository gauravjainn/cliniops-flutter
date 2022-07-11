part of 'routes.dart';

//auth routes
class AuthRoutes {
  /// leading string for routes in auth, this needs to be used when creating
  /// new route
  static const authLeading = '/auth-route';

  static const loginScreen = authLeading + '/login-screen';
  static const forgotPassword = authLeading + '/forgot-password-screen';

  static final authRoutes = <String>{loginScreen, forgotPassword};

  static Widget getPage(String currentRoute, Object? args) {
    Widget child;
    switch (currentRoute) {
      case AuthRoutes.loginScreen:
        child = const LoginScreen();
        break;
      case AuthRoutes.forgotPassword:
        child = const ForgotPasswordScreen();
        break;
      default:
        child = PageNotFound();
    }
    return child;
  }
}
