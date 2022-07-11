// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variable_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariableReqModel _$VariableReqModelFromJson(Map json) => VariableReqModel(
      variableId: json['variable_id'] as int,
      variableValue: json['variable_value'] as String,
      date: DateTime.parse(json['date'] as String),
      type: json['type'] as String,
    );

Map<String, dynamic> _$VariableReqModelToJson(VariableReqModel instance) =>
    <String, dynamic>{
      'variable_id': instance.variableId,
      'variable_value': instance.variableValue,
      'date': getStringFromDate(instance.date),
      'type': instance.type,
    };
