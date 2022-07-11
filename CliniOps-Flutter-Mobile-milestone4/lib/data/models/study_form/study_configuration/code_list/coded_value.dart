import 'package:clini_app/controllers/controllers.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:clini_app/utils/utils.dart';

part 'coded_value.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class CodedValue {
  @JsonKey(fromJson: parseInt)
  int? codedValue;
  Map<int, String> lang;

  CodedValue({
    this.codedValue,
    required this.lang,
  });

  factory CodedValue.fromJson(Map json) => _$CodedValueFromJson(json);

  Map<String, dynamic> toJson() => _$CodedValueToJson(this);

  @override
  String toString() {
    final notifier = GetIt.I.get<StudyNotifier>();
    return notifier.getNameFromCodedValue(this);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CodedValue &&
        other.codedValue == codedValue &&
        mapEquals(other.lang, lang);
  }

  @override
  int get hashCode => codedValue.hashCode ^ lang.hashCode;
}
