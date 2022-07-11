// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_param_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudyParamModel _$StudyParamModelFromJson(Map json) => StudyParamModel(
      id: parseInt(json['id']),
      paramKey: json['param_key'] as String?,
      paramValue: json['param_value'] as String?,
      type: json['type'] as String?,
      description: json['description'] as String?,
      disabled: parseInt(json['disabled']),
    );

Map<String, dynamic> _$StudyParamModelToJson(StudyParamModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'param_key': instance.paramKey,
      'param_value': instance.paramValue,
      'type': instance.type,
      'description': instance.description,
      'disabled': instance.disabled,
    };
