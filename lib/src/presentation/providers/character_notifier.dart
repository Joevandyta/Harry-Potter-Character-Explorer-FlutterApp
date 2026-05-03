import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:harry_potter_char_app/src/data/character_providers.dart';
import 'package:harry_potter_char_app/src/domain/models/character_model.dart';
import 'package:harry_potter_char_app/src/domain/models/house_name.dart';
import 'character_state.dart';

part 'character_notifier.g.dart';

@riverpod
class CharacterNotifier extends _$CharacterNotifier {
  @override
  CharacterState build() {
    return CharacterState.initial();
  }

  Future<void> getCharacters(String house) async {
    if (state.characters[house]?.isNotEmpty ?? false) {
      return;
    }

    state = state.copyWith(status: CharacterStatus.loading);

    try {
      late List<CharacterModel> result;
      final repository = ref.read(repositoryProvider);

      if (house == House.all.displayName) {
        result = await repository.getCharacters();
      } else {
        result = await repository.getCharacterInHouse(house);
      }

      final updatedMap = Map<String, List<CharacterModel>>.from(
        state.characters,
      );
      updatedMap[house] = result;

      state = state.copyWith(
        status: CharacterStatus.success,
        characters: updatedMap,
        filteredCharacters: state.searchQuery.isEmpty
            ? updatedMap
            : _filterCharacters(updatedMap, state.searchQuery),
      );
    } catch (e) {
      state = state.copyWith(
        status: CharacterStatus.error,
        error: e.toString(),
      );
    }
  }

  void searchCharacters(String query) {
    final lowercaseQuery = query.toLowerCase();

    if (lowercaseQuery.isEmpty) {
      state = state.copyWith(
        searchQuery: '',
        filteredCharacters: state.characters,
      );
      return;
    }
    final filtered = _filterCharacters(state.characters, lowercaseQuery);

    state = state.copyWith(filteredCharacters: filtered, searchQuery: query);
  }

  Map<String, List<CharacterModel>> _filterCharacters(
    Map<String, List<CharacterModel>> source,
    String query,
  ) {
    return source.map((house, characters) {
      final result = characters.where((character) {
        return character.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
      return MapEntry(house, result);
    });
  }
}
