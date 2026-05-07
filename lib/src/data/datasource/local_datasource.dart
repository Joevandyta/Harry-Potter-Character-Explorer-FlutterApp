import 'package:harry_potter_char_app/src/domain/models/favorite_character.dart';
import 'package:isar_community/isar.dart';

class LocalDataSource {
  final Isar isar;

  LocalDataSource({required this.isar});

  Future<void> addFavorite(FavoriteCharacter favorite) async {
    await isar.writeTxn(() async {
      await isar.favoriteCharacters.put(favorite);
    });
  }

  Future<void> removeFavorite(String characterId) async {
    await isar.writeTxn(() async {
      await isar.favoriteCharacters.filter().characterIdEqualTo(characterId).deleteAll();
    });
  }

  Future<List<FavoriteCharacter>> getFavorites() async {
    return await isar.favoriteCharacters.where().findAll();
  }

  Future<bool> isFavorite(String characterId) async {
    final favorite = await isar.favoriteCharacters.filter().characterIdEqualTo(characterId).findFirst();
    return favorite != null;
  }
}
