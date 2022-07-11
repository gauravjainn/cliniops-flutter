// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitReqModel _$VisitReqModelFromJson(Map json) => VisitReqModel(
      visitsId: json['visits_id'] as int,
      forms: (json['forms'] as List<dynamic>)
          .map((e) => FormReqModel.fromJson(e as Map))
          .toList(),
    );

Map<String, dynamic> _$VisitReqModelToJson(VisitReqModel instance) =>
    <String, dynamic>{
      'visits_id': instance.visitsId,
      'forms': instance.forms.map((e) => e.toJson()).toList(),
    };
