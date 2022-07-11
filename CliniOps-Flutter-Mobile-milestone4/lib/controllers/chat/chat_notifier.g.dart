// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_notifier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatNotifier _$ChatNotifierFromJson(Map json) => ChatNotifier()
  ..messageList = (json['messageList'] as List<dynamic>)
      .map((e) => Message.fromJson(e as Map))
      .toList();

Map<String, dynamic> _$ChatNotifierToJson(ChatNotifier instance) =>
    <String, dynamic>{
      'messageList': instance.messageList.map((e) => e.toJson()).toList(),
    };
