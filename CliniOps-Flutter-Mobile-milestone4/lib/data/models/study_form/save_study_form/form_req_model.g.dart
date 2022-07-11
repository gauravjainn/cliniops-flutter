// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormReqModel _$FormReqModelFromJson(Map json) => FormReqModel(
      formId: json['form_id'] as int,
      itemGroups: (json['item_groups'] as List<dynamic>)
          .map((e) => FormItemGroupReqModel.fromJson(e as Map))
          .toList(),
      isCompleted: json['isCompleted'] as bool? ?? false,
      isDataUpload: json['isDataUpload'] as bool? ?? false,
    );

Map<String, dynamic> _$FormReqModelToJson(FormReqModel instance) =>
    <String, dynamic>{
      'form_id': instance.formId,
      'item_groups': instance.itemGroups.map((e) => e.toJson()).toList(),
      'isCompleted': instance.isCompleted,
      'isDataUpload': instance.isDataUpload,
    };
