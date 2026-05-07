import 'dart:convert';
import 'package:harry_potter_char_app/src/data/datasource/remote_datasource.dart';
import 'package:harry_potter_char_app/src/data/datasource/local_datasource.dart';
import 'package:harry_potter_char_app/src/domain/models/character_model.dart';
import 'package:harry_potter_char_app/src/domain/models/favorite_character.dart';
import 'package:harry_potter_char_app/src/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  RepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  @override
  Future<List<CharacterModel>> getCharacters() async {
    var data = await remoteDataSource.getCharacters();
    return data;
  }

  @override
  Future<List<CharacterModel>> getCharacterInHouse(String house) async {
    return await remoteDataSource.getCharactersInHouse(house);
  }

  @override
  Future<List<CharacterModel>> getStaff() async {
    return await remoteDataSource.getStaff();
  }

  @override
  Future<List<CharacterModel>> getStudents() async {
    return await remoteDataSource.getStudents();
  }

  @override
  Future<void> addFavorite(CharacterModel character) async {
    final favorite = FavoriteCharacter()
      ..characterId = character.id
      ..characterJson = jsonEncode(character.toJson());
    await localDataSource.addFavorite(favorite);
  }

  @override
  Future<void> removeFavorite(String characterId) async {
    await localDataSource.removeFavorite(characterId);
  }

  @override
  Future<List<CharacterModel>> getFavorites() async {
    final favorites = await localDataSource.getFavorites();
    return favorites
        .map((f) => CharacterModel.fromJson(jsonDecode(f.characterJson)))
        .toList();
  }

  @override
  Future<bool> isFavorite(String characterId) async {
    return await localDataSource.isFavorite(characterId);
  }
}
