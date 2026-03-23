import 'package:dio/dio.dart';

import '../../domain/models/character_model.dart';

class RemoteDataSource {
  final Dio dio;

  RemoteDataSource({required this.dio});

  Future<List<CharacterModel>> getCharacters() async {
    try {
      final response = await dio.get('api/characters');
      if (response.statusCode == 200) {
        final List data = response.data;
        return data
            .map((e) => CharacterModel.fromJson(e))
            .toList();
      } else {
        throw Exception("Failed to load characters");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    }
  }

  Future<List<CharacterModel>> getStudents() async {
    try {
      final response = await dio.get('api/characters/students');
      if (response.statusCode == 200) {
        final List data = response.data;
        return data
            .map((e) => CharacterModel.fromJson(e))
            .toList();
      } else {
        throw Exception("Failed to load students");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    }
  }

  Future<List<CharacterModel>> getStaff() async {
    try {
      final response = await dio.get('api/characters/staff');
      if (response.statusCode == 200) {
        final List data = response.data;
        return data
            .map((e) => CharacterModel.fromJson(e))
            .toList();
      } else {
        throw Exception("Failed to load staff");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    }
  }

  Future<List<CharacterModel>> getCharactersInHouse(String house) async {
    try {
      final response = await dio.get('/api/characters/house/$house');
      if (response.statusCode == 200) {
        final List data = response.data;
        return data
            .map((e) => CharacterModel.fromJson(e))
            .toList();
      } else {
        throw Exception("Failed to load characters");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    }
  }
}
