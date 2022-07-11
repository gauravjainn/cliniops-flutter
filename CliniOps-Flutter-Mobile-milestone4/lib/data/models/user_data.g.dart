// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map json) => UserData(
      subjectId: json['subject_id'] as String?,
      subjectUserId: json['subject_user_id'] as String?,
      subjectDisplayId: json['subjectDisplayId'] as String?,
      studyId: json['study_id'] as String?,
      profileDetails: json['profileDetails'] == null
          ? null
          : ProfileDetails.fromJson(json['profileDetails'] as Map),
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'subject_id': instance.subjectId,
      'subject_user_id': instance.subjectUserId,
      'subjectDisplayId': instance.subjectDisplayId,
      'study_id': instance.studyId,
      'profileDetails': instance.profileDetails?.toJson(),
    };
