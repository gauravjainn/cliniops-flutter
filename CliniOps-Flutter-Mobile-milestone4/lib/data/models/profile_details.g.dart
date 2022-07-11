// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDetails _$ProfileDetailsFromJson(Map json) => ProfileDetails(
      username: json['Username'] as String?,
      subjectID: json['Subject ID'] as String?,
      email: json['Email'] as String?,
      phone: json['Phone'] as String?,
      registeredBy: json['Registered By'] as String?,
      registeredDate: json['Registered Date'] as String?,
      group: json['Group'] as String?,
      site: json['Site'] as String?,
      subjectCommonId: json['subjectCommonId'] as String?,
      subjectUserId: json['subjectUserId'] as String?,
    );

Map<String, dynamic> _$ProfileDetailsToJson(ProfileDetails instance) =>
    <String, dynamic>{
      'Username': instance.username,
      'Subject ID': instance.subjectID,
      'Email': instance.email,
      'Phone': instance.phone,
      'Registered By': instance.registeredBy,
      'Registered Date': instance.registeredDate,
      'Group': instance.group,
      'Site': instance.site,
      'subjectCommonId': instance.subjectCommonId,
      'subjectUserId': instance.subjectUserId,
    };
