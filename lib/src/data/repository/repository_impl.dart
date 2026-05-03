import 'package:harry_potter_char_app/src/data/datasource/remote_datasource.dart';
import 'package:harry_potter_char_app/src/domain/models/character_model.dart';
import 'package:harry_potter_char_app/src/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  RepositoryImpl({required this.remoteDataSource});

  final RemoteDataSource remoteDataSource;

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
}
