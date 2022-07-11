import 'package:clini_app/utils/utils.dart';

/// To enable this need to pass in --dart-define while building apk
/// eg. flutter (run | build) --dart-define=TEST_MODE=true
/// or user ./build.sh to build apk with release mode and use -t to enable testing int the app

enum ENV { DEV, STAG, PROD, CUSTOM }

final env = EnumValues({
  'DEV': ENV.DEV,
  'STAG': ENV.STAG,
  'PROD': ENV.PROD,
  'CUSTOM': ENV.CUSTOM,
});

class EnvironmentVars {
  static const String TEST_MODE = 'TEST_MODE';
  static const String ENV = 'ENV';
}
