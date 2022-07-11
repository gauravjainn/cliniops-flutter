// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudyConfigurationFormModel _$StudyConfigurationFormModelFromJson(Map json) =>
    StudyConfigurationFormModel(
      formId: parseInt(json['form_id']),
      formTypeId: parseInt(json['form_type_id']),
      confFormsDeletedAt: parseInt(json['st_conf_forms_deleted_at']),
      oId: json['oid'] as String?,
      itemGroups: (json['item_groups'] as List<dynamic>?)
          ?.map((e) => FormItemGroupModel.fromJson(e as Map))
          .toList(),
    )..formNameLabels = (json['form_name_labels'] as List<dynamic>?)
        ?.map((e) => StudyLanguageModel.fromJson(e as Map))
        .toList();

Map<String, dynamic> _$StudyConfigurationFormModelToJson(
        StudyConfigurationFormModel instance) =>
    <String, dynamic>{
      'form_id': instance.formId,
      'form_type_id': instance.formTypeId,
      'st_conf_forms_deleted_at': instance.confFormsDeletedAt,
      'oid': instance.oId,
      'item_groups': instance.itemGroups?.map((e) => e.toJson()).toList(),
      'form_name_labels':
          instance.formNameLabels?.map((e) => e.toJson()).toList(),
    };
