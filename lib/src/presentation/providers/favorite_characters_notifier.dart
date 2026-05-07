import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:harry_potter_char_app/src/domain/models/character_model.dart';
import 'package:harry_potter_char_app/src/data/character_providers.dart';

part 'favorite_characters_notifier.g.dart';

@riverpod
class FavoriteCharactersNotifier extends _$FavoriteCharactersNotifier {
  @override
  Future<List<CharacterModel>> build() async {
    final repository = ref.watch(repositoryProvider);
    return await repository.getFavorites();
  }

  Future<void> toggleFavorite(CharacterModel character) async {
    final repository = ref.read(repositoryProvider);
    final isFav = await repository.isFavorite(character.id);
    if (isFav) {
      await repository.removeFavorite(character.id);
    } else {
      await repository.addFavorite(character);
    }
    // Refresh the list
    ref.invalidateSelf();
  }
}

@riverpod
bool isFavorite(Ref ref, String characterId) {
  final favAsync = ref.watch(favoriteCharactersProvider);
  return favAsync.when(
    data: (list) => list.any((c) => c.id == characterId),
    loading: () => false,
    error: (_, __) => false,
  );
}
