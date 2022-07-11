import 'package:clini_app/controllers/auth/auth_notifier.dart';
import 'package:clini_app/data/data.dart';
import 'package:clini_app/routes/routes.dart';
import 'package:clini_app/services/services.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() async {
    final _notifier = context.read<AuthNotifier>();
    _notifier.getLogoApi();
    AppEnvironment.packageInfo = await PackageInfo.fromPlatform();
    AppEnvironment.user = _notifier.userData;
    // AppEnvironment.cubeUser = notifier.cubeUser;

    await Future.delayed(splashAnim);

    _handleNavigationLogic();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image(image: AssetImage(Images.logoIcon,),height: 120,width: 120,)),
    );
  }

  void _handleNavigationLogic() async {
    var sessionId = await SecureStorage().getToken(DbKeys.sessionId);
    // check the user is login or not
    if (sessionId?.isNotEmpty ?? false) {
      // navigate to dashboard screen
      AppEnvironment.navigator.pushReplacementNamed(GeneralRoutes.navbar);
    } else {
      // navigate to language screen
      AppEnvironment.navigator.pushReplacementNamed(AuthRoutes.loginScreen);
    }
  }
}
