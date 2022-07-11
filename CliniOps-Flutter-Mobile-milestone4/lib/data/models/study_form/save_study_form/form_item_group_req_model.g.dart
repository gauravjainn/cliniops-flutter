// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_item_group_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormItemGroupReqModel _$FormItemGroupReqModelFromJson(Map json) =>
    FormItemGroupReqModel(
      itemGroupId: json['item_group_id'] as int,
      variables: (json['variables'] as List<dynamic>)
          .map((e) => VariableReqModel.fromJson(e as Map))
          .toList(),
    );

Map<String, dynamic> _$FormItemGroupReqModelToJson(
        FormItemGroupReqModel instance) =>
    <String, dynamic>{
      'item_group_id': instance.itemGroupId,
      'variables': instance.variables.map((e) => e.toJson()).toList(),
    };
