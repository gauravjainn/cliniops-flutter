import 'package:clini_app/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'form_req_model.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class FormReqModel {
  @JsonKey(name: 'form_id')
  int formId;
  @JsonKey(name: 'item_groups')
  List<FormItemGroupReqModel> itemGroups;
  bool isCompleted;
  bool isDataUpload;

  FormReqModel({
    required this.formId,
    required this.itemGroups,
    this.isCompleted = false,
    this.isDataUpload = false
  });

  factory FormReqModel.fromJson(Map json) => _$FormReqModelFromJson(json);

  Map<String, dynamic> toJson() => _$FormReqModelToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FormReqModel && other.formId == formId;
  }

  @override
  int get hashCode => formId.hashCode ^ itemGroups.hashCode;
}
