
import 'package:json_annotation/json_annotation.dart';


part 'wand_model.g.dart';
@JsonSerializable()
class Wand {
  final String wood;
  final String core;
  final double? length;

  Wand({
    required this.wood,
    required this.core,
    required this.length,
  });

  factory Wand.fromJson(Map<String, dynamic> json)
  => _$WandFromJson(json);
  Map<String, dynamic> toJson() => _$WandToJson(this);


  bool get isWandEmpty =>
      (wood.isEmpty) &&
          (core.isEmpty) &&
          length == null;
}