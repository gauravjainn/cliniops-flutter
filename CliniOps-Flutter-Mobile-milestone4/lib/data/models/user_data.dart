import 'package:clini_app/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class UserData {
  @JsonKey(name: 'subject_id')
  String? subjectId;
  @JsonKey(name: 'subject_user_id')
  String? subjectUserId;
  String? subjectDisplayId;
  @JsonKey(name: 'study_id')
  String? studyId;
  ProfileDetails? profileDetails;

  UserData({
    this.subjectId,
    this.subjectUserId,
    this.subjectDisplayId,
    this.studyId,
    this.profileDetails,
  });

  factory UserData.fromJson(Map json) => _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
