import 'package:clini_app/data/models/chat/message.dart';
import 'package:clini_app/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_notifier.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ChatNotifier with ChangeNotifier, CliniMixin<ChatNotifier> {
  @JsonKey(ignore: true)
  late DatabaseReference databaseRef = FirebaseDatabase.instance.ref();

  List<Message> messageList = [];
 
  static Future<ChatNotifier> initialize() async {
    late ChatNotifier instance;
    try {
      instance = await ChatNotifier().init();
      
    } catch (e) {
      instance = ChatNotifier();
    }

    return instance;
  }

  @override
  ChatNotifier fromJson(Map json) => _$ChatNotifierFromJson(json);

  @override
  Map<String, dynamic> toJson(ChatNotifier notifier) =>
      _$ChatNotifierToJson(notifier);
}
