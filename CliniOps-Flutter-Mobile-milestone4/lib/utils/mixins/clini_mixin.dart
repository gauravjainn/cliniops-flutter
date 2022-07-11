import 'package:clini_app/services/services.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:json_annotation/json_annotation.dart';

/// Extend this mixin to make your classes a worthy stack class
/// You'll be called [God of thunder]
mixin CliniMixin<T extends ChangeNotifier> on ChangeNotifier {
  /// Function definations for implementing toJson and fromJson methods
  Map<String, dynamic> toJson(T notifier);
  T fromJson(Map<String, dynamic> json);

  /// Now you are [God of thunder]
  /// It fetches data from [DbService class][Hive db] and gets all the info from a box named [GENERAL_BOX]
  /// with key named [T] for type of mixin for eg. [CardNotifier] and fetch the value and convert that [Map] using [fromJson] method
  ///
  /// call this function when you register your notifiers and this is async call might need to call with spread operators
  Future<T> init() async {
    var resp = await DbService().fetchData(
        DbEnvironment.generalBox, DbEnvironment.GENERAL_BOX, T.toString(), {});

    // Logger.logMsg(this, resp.toString());
    return _fromJson(resp!.cast<String, dynamic>());
  }

  /// To define general loader for whole app
  @JsonKey(ignore: true)
  bool isLoading = false;

  /// To show general loader for whole app
  void showLoader() {
    isLoading = true;
    Logger.logMsg('showLoader', isLoading);
    notifyListeners();
  }

  /// To show general loader for whole app
  void removeLoader() {
    isLoading = false;
    Logger.logMsg('removeLoader', isLoading);
    notifyListeners();
  }

  /// Overiding the notifyListeners from change notifier which enable us to save data every time you call [notifyListeners] method
  /// [Caution] don't unnecessary call [notifyListeners] as it will trigger db call to save data - working on to fix value equality for types
  /// get the data from singleton using [GetIt.I] of type [T] which we have defined in our root and convert using [fromJson]
  /// and calls the [_storeData] function to store data [FYI: it's a compute function]
  @override
  void notifyListeners() {
    // TODO: check for value equality
    final data = _toJson(GetIt.I<T>());
    _storeData(data);
    // Logger.logMsg(this, data);

    super.notifyListeners();
  }

  /// private method to call overridden [toJson]
  Map<String, dynamic> _toJson(T notifier) {
    return toJson(notifier);
  }

  /// private method to call overridden [fromJson]
  T _fromJson(Map<String, dynamic> json) {
    return fromJson(json);
  }

  /// clears the data of a particular notifier from db
  Future<bool> clear() async {
    return await DbService().removeDataWithKey(
      DbEnvironment.generalBox,
      DbEnvironment.GENERAL_BOX,
      T.toString(),
    );
  }

  /// It gets called everytime [notifyListeners] is triggered get the DB_PATH from env and init a hive db with that [dbPath] var using [_perform] function
  /// [FYI: compute creates an isolates and remove when completed] so all the compution is happening in isolate only
  /// to pass data into isolate we defined a list which contains the
  /// 1. [data] which we want to store
  /// 2. [T.toString()] which is the key name which we want to store. FYI: you can always override [toString()] to change key name which you want to store
  /// 3. [dbPath] to init hive db at that path and store the value
  void _storeData(Map<String, dynamic> data) async {
    try {
      DbService().storeDataWithKey(DbEnvironment.generalBox,
          DbEnvironment.GENERAL_BOX, T.toString(), data);
      // TODO: enable this once package is done
      // compute(_perform, [data, T.toString(), DbEnvironment.DB_PATH]);
    } catch (e) {
      Logger.logError(this, e.toString());
    }
  }

  /// [Heart of God of thunder]
  /// FYI: this runs in an isolate
  /// it gets the list of the params passed from compute funtion
  /// initializes the hive db using [init] method everytime. Don't worry [Hive] is smart it will return the same instance which was created prev
  /// stores the data with give key from [compute] function and store the data as dart [Map]
  /// and returns the [void Future] which means execution of this function is successful
  /// [ENJOY]
  // static void _perform(List data) async {
  //   try {
  //     Hive.init(data[2] as String);
  //     await DbService().storeDataWithKey(DbEnvironment.generalBox,
  //         DbEnvironment.GENERAL_BOX, data[1] as String, data[0]);
  //   } catch (e) {
  //     Logger.logError('Isolate', e.toString());
  //   }
  //   return Future.value();
  // }
}
