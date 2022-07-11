import 'package:clini_app/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:clini_app/utils/utils.dart';

part 'form_variables.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class FormItemGroupVariableModel {
  @JsonKey(name: 'variable_id', fromJson: parseInt)
  int? variableId;

  // TODO: this can be enum need to check with BE
  @JsonKey(name: 'variable_itemid')
  String? variableItemId;

  // TODO: this can be enum need to check with BE
  @JsonKey(name: 'variable_datatype')
  String? variableDataType;

  @JsonKey(name: 'variable_rangefrom')
  String? variableRangeFrom;

  @JsonKey(name: 'variable_rangeto')
  String? variableRangeTo;

  @JsonKey(name: 'variable_deleted_at', fromJson: parseInt)
  int? variableDeletedAt;

  @JsonKey(name: 'calculate_rule_id', fromJson: parseInt)
  int? calculateRuleId;

  @JsonKey(name: 'editcheck_rule_id', fromJson: parseInt)
  int? editCheckRuleId;

  @JsonKey(fromJson: parseInt)
  int? identifier;

  @JsonKey(name: 'control_format')
  String? controlFormat;

  @JsonKey(fromJson: parseInt)
  int? mandatory;

  @JsonKey(name: 'rule_id')
  String? ruleId;

  @JsonKey(name: 'variable_position_id', fromJson: parseInt)
  int? variablePositionId;

  @JsonKey(name: 'rule_oid')
  String? ruleOid;

  @JsonKey(name: 'itemGroup_variablelabel')
  List<StudyLanguageModel>? itemGroupVariableLabel;

  @JsonKey(name: 'codelist_id', fromJson: parseInt)
  int? codeListId;

  FormItemGroupVariableModel({
    this.variableId,
    this.variableItemId,
    this.variableDataType,
    this.variableRangeFrom,
    this.variableRangeTo,
    this.variableDeletedAt,
    this.calculateRuleId,
    this.editCheckRuleId,
    this.identifier,
    this.controlFormat,
    this.mandatory,
    this.ruleId,
    this.variablePositionId,
    this.ruleOid,
    this.itemGroupVariableLabel,
    this.codeListId,
  });

  factory FormItemGroupVariableModel.fromJson(Map json) =>
      _$FormItemGroupVariableModelFromJson(json);

  Map<String, dynamic> toJson() => _$FormItemGroupVariableModelToJson(this);
}
