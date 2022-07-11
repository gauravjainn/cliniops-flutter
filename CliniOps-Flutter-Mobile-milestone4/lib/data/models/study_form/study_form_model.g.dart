// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_form_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudyFormModel _$StudyFormModelFromJson(Map json) => StudyFormModel(
      title: json['title'] as String?,
      studyId: parseInt(json['study_id']),
      studyDescription: json['studydescription'] as String?,
      contact: json['contact'] as String?,
      status: parseInt(json['Status']),
      studyConfiguration: json['studyConfiguration'] == null
          ? null
          : StudyConfigurationModel.fromJson(json['studyConfiguration'] as Map),
    );

Map<String, dynamic> _$StudyFormModelToJson(StudyFormModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'study_id': instance.studyId,
      'studydescription': instance.studyDescription,
      'contact': instance.contact,
      'Status': instance.status,
      'studyConfiguration': instance.studyConfiguration?.toJson(),
    };
