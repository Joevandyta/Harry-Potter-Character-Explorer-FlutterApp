import 'package:harry_potter_char_app/data/datasource/remote_datasource.dart';
import 'package:harry_potter_char_app/domain/models/character_model.dart';
import 'package:harry_potter_char_app/domain/repository/repository.dart';

class RepositoryImpl implements Repository{
  final RemoteDataSource remoteDataSource;

  RepositoryImpl({ required this.remoteDataSource});

  @override
  Future<List<CharacterModel>> getCharacters() async {
    var data = await remoteDataSource.getCharacters();
    return data;
  }

  @override
  Future<List<CharacterModel>> getCharacterInHouse(String house) async {
    // TODO: implement getCharacterInHouse

    return await remoteDataSource.getCharactersInHouse(house);
  }

  @override
  Future<List<CharacterModel>> getStaff() async {
    // TODO: implement getStaff
    return await remoteDataSource.getStaff();
  }

  @override
  Future<List<CharacterModel>> getStudents() async {
    // TODO: implement getStudents
    return await remoteDataSource.getStudents();
  }
}