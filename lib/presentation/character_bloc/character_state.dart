import '../../domain/models/character_model.dart';

enum CharacterStatus { initial, loading, success, error }

class CharacterState {
  final CharacterStatus status;
  final String? error;
  final Map<String, List<CharacterModel>> characters;
  final Map<String, List<CharacterModel>> filteredCharacters;
  final String searchQuery;

  CharacterState._({required this.status, this.error, required this.characters,required this.filteredCharacters, required this.searchQuery});

  factory CharacterState.initial() =>
      CharacterState._(status: CharacterStatus.initial, characters: {}, filteredCharacters:{}, searchQuery: '');

  CharacterState copyWith({
    CharacterStatus? status,
    String? error,
    Map<String, List<CharacterModel>>? characters,
    Map<String, List<CharacterModel>>? filteredCharacters,
    String? searchQuery,
  }) {
    return CharacterState._(
      status: status ?? this.status,
      error: error ?? this.error,
      characters: characters ?? this.characters,
      filteredCharacters: filteredCharacters ?? this.filteredCharacters,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}


