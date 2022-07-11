// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_form_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudyFormReqModel _$StudyFormReqModelFromJson(Map json) => StudyFormReqModel(
      studyId: json['studyId'] as int?,
      visits: (json['visits'] as List<dynamic>?)
          ?.map((e) => VisitReqModel.fromJson(e as Map))
          .toList(),
    );

Map<String, dynamic> _$StudyFormReqModelToJson(StudyFormReqModel instance) =>
    <String, dynamic>{
      'studyId': instance.studyId,
      'visits': instance.visits?.map((e) => e.toJson()).toList(),
    };
