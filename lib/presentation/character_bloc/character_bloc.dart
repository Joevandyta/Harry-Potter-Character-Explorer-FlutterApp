import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter_char_app/domain/models/character_model.dart';
import 'package:harry_potter_char_app/domain/models/house_name.dart';
import 'package:harry_potter_char_app/domain/repository/repository.dart';

import 'character_event.dart';
import 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final Repository repository;

  CharacterBloc({required this.repository})
    : super(CharacterState.initial()) {
    on<GetCharacterEvent>(onGetCharacterEvent);
    // on<GetCharactersByHouse>(onGetCharactersByHouse);
    on<GetCharactersByQuery>(
      onGetCharactersByQuery,
      // transformer: (events, mapper) =>
      //     events.debounceTime(const Duration(milliseconds: 300)).switchMap(mapper),
    );

  }

  Future onGetCharacterEvent(
    GetCharacterEvent event,
    Emitter emit,
  ) async {

    if (state.characters[event.house]?.isNotEmpty ?? false) {
      return;
    }
    emit(state.copyWith(status: CharacterStatus.loading));
    try{
      late List<CharacterModel> result = [];

      if(event.house == House.all.displayName){
        result = await repository.getCharacters();
      }
      else{
        result = await repository.getCharacterInHouse(event.house);
      }
      final updatedMap = Map<String, List<CharacterModel>>.from(
        state.characters,
      );
      updatedMap[event.house] = result;
      emit(state.copyWith(status: CharacterStatus.success, characters: updatedMap));
    }
    catch(e){
      emit(state.copyWith(status: CharacterStatus.error, error: e.toString()));
    }
  }

  Future onGetCharactersByQuery(
    GetCharactersByQuery event,
    Emitter emit,
  ) async {
    final query = event.query.toLowerCase();

    if (query.isEmpty) {
      emit(
        state.copyWith(
          searchQuery: '',
          filteredCharacters: state.characters,
        ),
      );
      return;
    }
    final filtered = state.characters.map((house, characters) {
      final result = characters.where((character) {
        return character.name.toLowerCase().contains(query);
      }).toList();
      return MapEntry(house, result);
    });
    emit(
      state.copyWith(
        filteredCharacters: filtered,
        searchQuery: event.query,
      ),
    );
  }
}
