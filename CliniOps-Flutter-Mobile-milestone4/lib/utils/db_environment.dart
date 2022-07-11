import 'package:hive/hive.dart';

class DbEnvironment {
  static late String dbPath;

  /// Box objects
  static Box? generalBox;

  /// Collection Names
  static const GENERAL_BOX = 'GENERAL_BOX';
}
