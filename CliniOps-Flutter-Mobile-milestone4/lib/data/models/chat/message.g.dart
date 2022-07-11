// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map json) => Message(
      message: json['message'] as String?,
      date: json['date'] as String?,
      sendByUser: json['sendByUser'] as bool? ?? false,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'message': instance.message,
      'date': instance.date,
      'sendByUser': instance.sendByUser,
    };
