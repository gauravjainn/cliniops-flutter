// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annotations_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Annotations _$AnnotationsFromJson(Map json) => Annotations(
      xLoc: parseDouble(json['x_loc']),
      yLoc: parseDouble(json['y_loc']),
      annotation: json['annotation'] as String?,
      scaling: (json['scaling'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$AnnotationsToJson(Annotations instance) =>
    <String, dynamic>{
      'x_loc': instance.xLoc,
      'y_loc': instance.yLoc,
      'annotation': instance.annotation,
      'scaling': instance.scaling,
    };
