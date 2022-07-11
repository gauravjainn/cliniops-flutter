// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inform_consent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InformedConsentModel _$InformedConsentModelFromJson(Map json) =>
    InformedConsentModel(
      doc_title_id: json['doc_title_id'] as String?,
      doc_studyphase_id: json['doc_studyphase_id'] as String?,
      doc_type: json['doc_type'] as String?,
      id: json['id'] as String?,
      orig_filename: json['orig_filename'] as String?,
      entity_id: json['entity_id'] as String?,
      status: json['status'] as String?,
      version: json['version'] as String?,
      languageId: json['languageId'] as String?,
      file_location: json['file_location'] as String?,
      displayVersion: json['displayVersion'] as String?,
      annotations: (json['annotations'] as Map?)?.map(
        (k, e) => MapEntry(
            int.parse(k as String),
            (e as List<dynamic>)
                .map((e) => Annotations.fromJson(e as Map))
                .toList()),
      ),
    );

Map<String, dynamic> _$InformedConsentModelToJson(
        InformedConsentModel instance) =>
    <String, dynamic>{
      'doc_title_id': instance.doc_title_id,
      'doc_studyphase_id': instance.doc_studyphase_id,
      'doc_type': instance.doc_type,
      'id': instance.id,
      'orig_filename': instance.orig_filename,
      'entity_id': instance.entity_id,
      'status': instance.status,
      'version': instance.version,
      'languageId': instance.languageId,
      'file_location': instance.file_location,
      'displayVersion': instance.displayVersion,
      'annotations': instance.annotations?.map(
          (k, e) => MapEntry(k.toString(), e.map((e) => e.toJson()).toList())),
    };
