import 'package:json_annotation/json_annotation.dart';

part 'blob_details.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class FormBlobDetailModel {
  @JsonKey(name: 'orig_filename')
  String? originalFileName;

  @JsonKey(name: 'file_type')
  String? fileType;

  @JsonKey(name: 'file_size')
  String? fileSize;

  @JsonKey(name: 'file_location')
  String? fileLocation;

  FormBlobDetailModel({
    this.originalFileName,
    this.fileType,
    this.fileSize,
    this.fileLocation,
  });

  factory FormBlobDetailModel.fromJson(Map json) =>
      _$FormBlobDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$FormBlobDetailModelToJson(this);
}
