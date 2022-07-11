import 'package:clini_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

/// Flutter extensions for Hive.
extension HiveX on HiveInterface {
  /// Initializes Hive with the path from [getApplicationDocumentsDirectory].
  Future initFlutter() async {
    WidgetsFlutterBinding.ensureInitialized();
    var appDir = await getApplicationDocumentsDirectory();
    DbEnvironment.dbPath = appDir.path;
    Hive.init(DbEnvironment.dbPath);
  }
}
