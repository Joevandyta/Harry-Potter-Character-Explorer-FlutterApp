import 'package:json_annotation/json_annotation.dart';

import 'wand_model.dart';

part 'character_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CharacterModel {
  final String id;
  final String name;
  @JsonKey(name: "alternate_names")
  final List<String> alternateNames;
  final String? species;
  final String? gender;
  final String? house;
  final String? dateOfBirth;
  final int? yearOfBirth;
  final bool wizard;
  final String? ancestry;
  final String? eyeColour;
  final String? hairColour;
  final Wand? wand;
  final String? patronus;
  final bool hogwartsStudent;
  final bool hogwartsStaff;
  final String? actor;
  @JsonKey(name: "alternate_actors")
  final List<dynamic> alternateActors;
  final bool alive;
  final String? image;

  CharacterModel({
    required this.id,
    required this.name,
    required this.alternateNames,
    required this.species,
    required this.gender,
    required this.house,
    required this.dateOfBirth,
    required this.yearOfBirth,
    required this.wizard,
    required this.ancestry,
    required this.eyeColour,
    required this.hairColour,
    required this.wand,
    required this.patronus,
    required this.hogwartsStudent,
    required this.hogwartsStaff,
    required this.actor,
    required this.alternateActors,
    required this.alive,
    required this.image,
  });


  factory CharacterModel.fromJson(Map<String, dynamic> json)
  => _$CharacterModelFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterModelToJson(this);
}