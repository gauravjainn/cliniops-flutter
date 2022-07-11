import 'package:json_annotation/json_annotation.dart';

import 'package:clini_app/utils/utils.dart';

part 'global_language_model.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class GlobalLanguageModel {
  @JsonKey(name: 'lang_id', fromJson: parseInt)
  int? languageId;
  String? languagename;
  String? locale;

  GlobalLanguageModel({
    this.languageId,
    this.languagename,
    this.locale,
  });

  factory GlobalLanguageModel.fromJson(Map json) =>
      _$GlobalLanguageModelFromJson(json);

  Map<String, dynamic> toJson() => _$GlobalLanguageModelToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GlobalLanguageModel && other.languageId == languageId;
  }

  @override
  int get hashCode => languageId.hashCode;
}
