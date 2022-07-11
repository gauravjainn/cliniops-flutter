import 'package:clini_app/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'form_item_group_req_model.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class FormItemGroupReqModel {
  @JsonKey(name: 'item_group_id')
  int itemGroupId;
  List<VariableReqModel> variables;

  FormItemGroupReqModel({
    required this.itemGroupId,
    required this.variables,
  });

  factory FormItemGroupReqModel.fromJson(Map json) =>
      _$FormItemGroupReqModelFromJson(json);

  Map<String, dynamic> toJson() => _$FormItemGroupReqModelToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FormItemGroupReqModel && other.itemGroupId == itemGroupId;
  }

  @override
  int get hashCode => itemGroupId.hashCode ^ variables.hashCode;
}
