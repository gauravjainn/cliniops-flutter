import 'package:json_annotation/json_annotation.dart';

import 'package:clini_app/data/data.dart';
import 'package:clini_app/utils/utils.dart';

part 'form_item_group.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class FormItemGroupModel {
  @JsonKey(name: 'item_group_id', fromJson: parseInt)
  int? itemGroupId;
  @JsonKey(name: 'item_group_deleted_at', fromJson: parseInt)
  int? itemGroupDeletedAt;
  @JsonKey(name: 'blob_artifact_id', fromJson: parseInt)
  int? blobArtifactId;
  // TODO: this can be enum need to check with BE
  @JsonKey(name: 'OID')
  String? oId;
  @JsonKey(name: 'item_group_position_id', fromJson: parseInt)
  int? itemGroupPositionId;
  @JsonKey(name: 'rule_id', fromJson: parseInt)
  int? ruleId;
  @JsonKey(fromJson: parseInt)
  int? repeat;
  @JsonKey(name: 'rule_oid')
  String? ruleOid;
  @JsonKey(name: 'itemGrouplabel')
  List<StudyLanguageModel>? itemGroupLabel;
  @JsonKey(fromJson: parseBlobDetails)
  FormBlobDetailModel? blobDetails;
  List<FormItemGroupVariableModel>? variables;

  FormItemGroupModel({
    this.itemGroupId,
    this.itemGroupDeletedAt,
    this.blobArtifactId,
    this.oId,
    this.itemGroupPositionId,
    this.ruleId,
    this.repeat,
    this.ruleOid,
    this.itemGroupLabel,
    this.blobDetails,
    this.variables,
  });

  factory FormItemGroupModel.fromJson(Map json) =>
      _$FormItemGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$FormItemGroupModelToJson(this);

  static FormBlobDetailModel? parseBlobDetails(json) {
    if (json is Map) {
      return FormBlobDetailModel.fromJson(json);
    }
  }
}
