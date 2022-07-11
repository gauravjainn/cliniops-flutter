import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class Message {
  @JsonKey(name: 'message')
  String? message;
  String? date;
  @JsonKey(defaultValue:false)
  bool? sendByUser;
  Message({
    this.message,
    this.date,
    this.sendByUser,
  });

  factory Message.fromJson(Map json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
