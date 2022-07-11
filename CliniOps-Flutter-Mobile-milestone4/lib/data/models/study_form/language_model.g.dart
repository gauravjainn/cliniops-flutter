// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudyLanguageModel _$StudyLanguageModelFromJson(Map json) => StudyLanguageModel(
      languageId: parseInt(json['language_id']),
      label: json['label'] as String?,
      name: json['name'] as String?,
      visitName: json['visit_name'] as String?,
    );

Map<String, dynamic> _$StudyLanguageModelToJson(StudyLanguageModel instance) =>
    <String, dynamic>{
      'language_id': instance.languageId,
      'label': instance.label,
      'name': instance.name,
      'visit_name': instance.visitName,
    };
