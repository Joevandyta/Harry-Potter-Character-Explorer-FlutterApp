abstract class CharacterEvent {}

// class GetCharacterEvent extends CharacterEvent{
// }

class GetCharacterEvent extends CharacterEvent {
  final String house;
  GetCharacterEvent(this.house);
}

class GetStaff extends CharacterEvent {}

class GetStudents extends CharacterEvent {}

class GetCharactersByQuery extends CharacterEvent {
  final String query;
  GetCharactersByQuery(this.query);
}