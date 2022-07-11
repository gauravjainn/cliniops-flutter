import 'package:json_annotation/json_annotation.dart';

import 'package:clini_app/utils/utils.dart';

part 'document.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class Document {
  @JsonKey(fromJson: parseInt)
  int? id;
  @JsonKey(name: 'orig_filename')
  String? origFileName;
  @JsonKey(name: 'file_location')
  String? fileLocation;
  String? date;
  String? status;
  Document({
    this.id,
    this.origFileName,
    this.fileLocation,
    this.date,
    this.status,
  });

  

  factory Document.fromJson(Map json) => _$DocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentToJson(this);
}
