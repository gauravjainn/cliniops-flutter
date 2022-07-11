// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_item_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormItemGroupModel _$FormItemGroupModelFromJson(Map json) => FormItemGroupModel(
      itemGroupId: parseInt(json['item_group_id']),
      itemGroupDeletedAt: parseInt(json['item_group_deleted_at']),
      blobArtifactId: parseInt(json['blob_artifact_id']),
      oId: json['OID'] as String?,
      itemGroupPositionId: parseInt(json['item_group_position_id']),
      ruleId: parseInt(json['rule_id']),
      repeat: parseInt(json['repeat']),
      ruleOid: json['rule_oid'] as String?,
      itemGroupLabel: (json['itemGrouplabel'] as List<dynamic>?)
          ?.map((e) => StudyLanguageModel.fromJson(e as Map))
          .toList(),
      blobDetails: FormItemGroupModel.parseBlobDetails(json['blobDetails']),
      variables: (json['variables'] as List<dynamic>?)
          ?.map((e) => FormItemGroupVariableModel.fromJson(e as Map))
          .toList(),
    );

Map<String, dynamic> _$FormItemGroupModelToJson(FormItemGroupModel instance) =>
    <String, dynamic>{
      'item_group_id': instance.itemGroupId,
      'item_group_deleted_at': instance.itemGroupDeletedAt,
      'blob_artifact_id': instance.blobArtifactId,
      'OID': instance.oId,
      'item_group_position_id': instance.itemGroupPositionId,
      'rule_id': instance.ruleId,
      'repeat': instance.repeat,
      'rule_oid': instance.ruleOid,
      'itemGrouplabel':
          instance.itemGroupLabel?.map((e) => e.toJson()).toList(),
      'blobDetails': instance.blobDetails?.toJson(),
      'variables': instance.variables?.map((e) => e.toJson()).toList(),
    };
