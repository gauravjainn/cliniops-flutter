import 'package:json_annotation/json_annotation.dart';

part 'profile_details.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ProfileDetails {
  @JsonKey(name: 'Username')
  String? username;
  @JsonKey(name: 'Subject ID')
  String? subjectID;
  @JsonKey(name: 'Email')
  String? email;
  @JsonKey(name: 'Phone')
  String? phone;
  @JsonKey(name: 'Registered By')
  String? registeredBy;
  @JsonKey(name: 'Registered Date')
  String? registeredDate;
  @JsonKey(name: 'Group')
  String? group;
  @JsonKey(name: 'Site')
  String? site;
  String? subjectCommonId;
  String? subjectUserId;

  ProfileDetails({
    this.username,
    this.subjectID,
    this.email,
    this.phone,
    this.registeredBy,
    this.registeredDate,
    this.group,
    this.site,
    this.subjectCommonId,
    this.subjectUserId,
  });

  factory ProfileDetails.fromJson(Map json) => _$ProfileDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDetailsToJson(this);
}
