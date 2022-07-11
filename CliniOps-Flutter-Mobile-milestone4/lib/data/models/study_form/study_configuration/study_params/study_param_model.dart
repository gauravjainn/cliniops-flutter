import 'package:json_annotation/json_annotation.dart';

import 'package:clini_app/utils/utils.dart';

part 'study_param_model.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class StudyParamModel {
  @JsonKey(fromJson: parseInt)
  int? id;

  @JsonKey(name: 'param_key')
  String? paramKey;

  @JsonKey(name: 'param_value')
  String? paramValue;

  // TODO: maybe enum
  String? type;

  String? description;

  @JsonKey(fromJson: parseInt)
  int? disabled;

  StudyParamModel({
    this.id,
    this.paramKey,
    this.paramValue,
    this.type,
    this.description,
    this.disabled,
  });

  factory StudyParamModel.fromJson(Map json) => _$StudyParamModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudyParamModelToJson(this);
}
