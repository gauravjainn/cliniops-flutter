// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_form_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitFormModel _$VisitFormModelFromJson(Map json) => VisitFormModel(
      visitId: parseInt(json['visit_id']),
      formId: parseInt(json['form_id']),
      formOrder: json['form_order'] as String?,
      visitTypeId: parseInt(json['visit_type_id']),
    );

Map<String, dynamic> _$VisitFormModelToJson(VisitFormModel instance) =>
    <String, dynamic>{
      'visit_id': instance.visitId,
      'form_id': instance.formId,
      'form_order': instance.formOrder,
      'visit_type_id': instance.visitTypeId,
    };
