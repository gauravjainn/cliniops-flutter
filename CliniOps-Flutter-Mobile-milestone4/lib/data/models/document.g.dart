// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map json) => Document(
      id: parseInt(json['id']),
      origFileName: json['orig_filename'] as String?,
      fileLocation: json['file_location'] as String?,
      date: json['date'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'id': instance.id,
      'orig_filename': instance.origFileName,
      'file_location': instance.fileLocation,
      'date': instance.date,
      'status': instance.status,
    };
