import '../../domain/models/character_model.dart';

abstract class Repository {
  Future<List<CharacterModel>> getCharacters();
  Future<List<CharacterModel>> getCharacterInHouse(String house);
  Future<List<CharacterModel>> getStudents();
  Future<List<CharacterModel>> getStaff();
}