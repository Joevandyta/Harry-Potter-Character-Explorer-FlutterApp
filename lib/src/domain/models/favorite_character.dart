import 'package:isar_community/isar.dart';

part 'favorite_character.g.dart';

@collection
class FavoriteCharacter {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String characterId;

  late String characterJson;
}
