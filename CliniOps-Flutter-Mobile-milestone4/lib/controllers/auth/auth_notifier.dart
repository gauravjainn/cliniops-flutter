import 'dart:convert';
import 'dart:typed_data';

import 'package:clini_app/data/data.dart';
import 'package:clini_app/repositories/repositories.dart';
import 'package:clini_app/services/services.dart';
import 'package:clini_app/utils/utils.dart';
// import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_notifier.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class AuthNotifier with ChangeNotifier, CliniMixin<AuthNotifier> {
  @JsonKey(ignore: true)
  late AuthRepo authRepo;
  @JsonKey(ignore: true)
  Uint8List? bytes;

  // @JsonKey(ignore: true)
  // late ConnectCubeService connectCubeService;
  // @JsonKey(ignore: true)
  UserData? userData;
  String? password;

  // CubeUser? cubeUser;

  AuthNotifier();

  static Future<AuthNotifier> initialize(
    AuthRepo repo,
    // ConnectCubeService connectCubeService,
  ) async {
    late AuthNotifier instance;

    try {
      instance = await AuthNotifier().init();
    } catch (e) {
      instance = AuthNotifier();
    }

    instance.authRepo = repo;

    // AppEnvironment.user = instance.userData;

    // ..connectCubeService = connectCubeService;

    return instance;
  }

  // Login API
  Future<Responser> login({
    required String email,
    required String password,
  }) async {
    final resp = await authRepo.login(email: email, password: password);
    if (!resp.isSuccess) {
      return resp;
    }
    // store the session id in local storage
    await SecureStorage().addPreferences(
      DbKeys.sessionId,
      authRepo.sessionId,
    );
    // update the data in variable
    userData = resp.data;
    AppEnvironment.user = userData;
    password = password;
    AppEnvironment.isUserLoggedIn = true;
    notifyListeners();

    // final res = await initializeChat();
    // if (res.isSuccess) {
    //   AppEnvironment.isUserLoggedIn = true;
    //   // cubeUser = res.data;
    //   // AppEnvironment.cubeUser = cubeUser;
    //   notifyListeners();
    // }
    return resp;
  }

  // Change Password API for Login User
  Future<Responser> changePassword({
    required String userId,
    required String oldPassword,
    required String newPassword,
  }) async {
    final res = await authRepo.changePassword(
      userId: userId,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    if (res.isSuccess) {
      password = newPassword;
    }
    return res;
  }

  // Future<Responser<CubeUser>> initializeChat() async {
  //   final login = AppEnvironment.user!.profileDetails!.username!;

  //   var userResp = await connectCubeService.getUserFromLogin(login);

  //   if (userResp.data == null) {
  //     userResp = await connectCubeService.signupUser(
  //       login,
  //       login + CUBE_PASS_TRAILING,
  //     );
  //   } else {
  //     userResp.data?.password = login + CUBE_PASS_TRAILING;
  //     userResp = await connectCubeService.loginUser(userResp.data!);
  //   }
  //   await connectCubeService.createCubeSession(userResp.data);

  //   return userResp;
  // }

  void clearData() {
    userData = null;
    authRepo = AuthRepo();
    notifyListeners();
  }

// Forgot Password API for User
  Future<Responser> forgotPassword({required String emailId}) async {
    return await authRepo.forgotPassword(emailId: emailId);
  }

  Future<Responser<String>> getLogo({required String username}) async {
    return await authRepo.getLogo(username: username);
  }

  Future<void> getLogoApi() async {
    final res = await authRepo.getLogo(username: '');
    if (res.isSuccess && res.data != null) {
      bytes = const Base64Decoder().convert(res.data!);
    }
    notifyListeners();
  }

  @override
  AuthNotifier fromJson(Map json) => _$AuthNotifierFromJson(json);

  @override
  Map<String, dynamic> toJson(AuthNotifier notifier) =>
      _$AuthNotifierToJson(notifier);
}
