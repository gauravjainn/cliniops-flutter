import 'package:clini_app/utils/custom_json_parser.dart';
import 'package:json_annotation/json_annotation.dart';

part 'variable_req_model.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class VariableReqModel {
  @JsonKey(name: 'variable_id')
  int variableId;

  @JsonKey(name: 'variable_value')
  String variableValue;

  @JsonKey(toJson: getStringFromDate)
  DateTime date;

  String type;

  VariableReqModel({
    required this.variableId,
    required this.variableValue,
    required this.date,
    required this.type,
  });

  factory VariableReqModel.fromJson(Map json) =>
      _$VariableReqModelFromJson(json);

  Map<String, dynamic> toJson() => _$VariableReqModelToJson(this);
}
