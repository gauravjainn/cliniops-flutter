// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_notifier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthNotifier _$AuthNotifierFromJson(Map json) => AuthNotifier()
  ..userData = json['userData'] == null
      ? null
      : UserData.fromJson(json['userData'] as Map)
  ..password = json['password'] as String?;

Map<String, dynamic> _$AuthNotifierToJson(AuthNotifier instance) =>
    <String, dynamic>{
      'userData': instance.userData?.toJson(),
      'password': instance.password,
    };
