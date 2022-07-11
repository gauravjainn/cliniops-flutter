// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_variables.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormItemGroupVariableModel _$FormItemGroupVariableModelFromJson(Map json) =>
    FormItemGroupVariableModel(
      variableId: parseInt(json['variable_id']),
      variableItemId: json['variable_itemid'] as String?,
      variableDataType: json['variable_datatype'] as String?,
      variableRangeFrom: json['variable_rangefrom'] as String?,
      variableRangeTo: json['variable_rangeto'] as String?,
      variableDeletedAt: parseInt(json['variable_deleted_at']),
      calculateRuleId: parseInt(json['calculate_rule_id']),
      editCheckRuleId: parseInt(json['editcheck_rule_id']),
      identifier: parseInt(json['identifier']),
      controlFormat: json['control_format'] as String?,
      mandatory: parseInt(json['mandatory']),
      ruleId: json['rule_id'] as String?,
      variablePositionId: parseInt(json['variable_position_id']),
      ruleOid: json['rule_oid'] as String?,
      itemGroupVariableLabel:
          (json['itemGroup_variablelabel'] as List<dynamic>?)
              ?.map((e) => StudyLanguageModel.fromJson(e as Map))
              .toList(),
      codeListId: parseInt(json['codelist_id']),
    );

Map<String, dynamic> _$FormItemGroupVariableModelToJson(
        FormItemGroupVariableModel instance) =>
    <String, dynamic>{
      'variable_id': instance.variableId,
      'variable_itemid': instance.variableItemId,
      'variable_datatype': instance.variableDataType,
      'variable_rangefrom': instance.variableRangeFrom,
      'variable_rangeto': instance.variableRangeTo,
      'variable_deleted_at': instance.variableDeletedAt,
      'calculate_rule_id': instance.calculateRuleId,
      'editcheck_rule_id': instance.editCheckRuleId,
      'identifier': instance.identifier,
      'control_format': instance.controlFormat,
      'mandatory': instance.mandatory,
      'rule_id': instance.ruleId,
      'variable_position_id': instance.variablePositionId,
      'rule_oid': instance.ruleOid,
      'itemGroup_variablelabel':
          instance.itemGroupVariableLabel?.map((e) => e.toJson()).toList(),
      'codelist_id': instance.codeListId,
    };
