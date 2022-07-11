// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blob_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormBlobDetailModel _$FormBlobDetailModelFromJson(Map json) =>
    FormBlobDetailModel(
      originalFileName: json['orig_filename'] as String?,
      fileType: json['file_type'] as String?,
      fileSize: json['file_size'] as String?,
      fileLocation: json['file_location'] as String?,
    );

Map<String, dynamic> _$FormBlobDetailModelToJson(
        FormBlobDetailModel instance) =>
    <String, dynamic>{
      'orig_filename': instance.originalFileName,
      'file_type': instance.fileType,
      'file_size': instance.fileSize,
      'file_location': instance.fileLocation,
    };
