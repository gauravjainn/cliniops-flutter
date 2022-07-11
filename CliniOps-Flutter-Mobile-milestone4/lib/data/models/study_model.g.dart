// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudyModel _$StudyModelFromJson(Map json) => StudyModel(
      id: parseInt(json['id']),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$StudyModelToJson(StudyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
