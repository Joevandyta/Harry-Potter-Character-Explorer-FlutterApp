// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wand_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wand _$WandFromJson(Map<String, dynamic> json) => Wand(
  wood: json['wood'] as String,
  core: json['core'] as String,
  length: (json['length'] as num?)?.toDouble(),
);

Map<String, dynamic> _$WandToJson(Wand instance) => <String, dynamic>{
  'wood': instance.wood,
  'core': instance.core,
  'length': instance.length,
};
