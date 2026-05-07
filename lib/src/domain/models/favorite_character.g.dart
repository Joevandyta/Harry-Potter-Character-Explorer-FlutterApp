// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_character.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFavoriteCharacterCollection on Isar {
  IsarCollection<FavoriteCharacter> get favoriteCharacters => this.collection();
}

const FavoriteCharacterSchema = CollectionSchema(
  name: r'FavoriteCharacter',
  id: 3321196451907247176,
  properties: {
    r'characterId': PropertySchema(
      id: 0,
      name: r'characterId',
      type: IsarType.string,
    ),
    r'characterJson': PropertySchema(
      id: 1,
      name: r'characterJson',
      type: IsarType.string,
    ),
  },

  estimateSize: _favoriteCharacterEstimateSize,
  serialize: _favoriteCharacterSerialize,
  deserialize: _favoriteCharacterDeserialize,
  deserializeProp: _favoriteCharacterDeserializeProp,
  idName: r'id',
  indexes: {
    r'characterId': IndexSchema(
      id: 8442520835599207285,
      name: r'characterId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'characterId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _favoriteCharacterGetId,
  getLinks: _favoriteCharacterGetLinks,
  attach: _favoriteCharacterAttach,
  version: '3.3.2',
);

int _favoriteCharacterEstimateSize(
  FavoriteCharacter object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.characterId.length * 3;
  bytesCount += 3 + object.characterJson.length * 3;
  return bytesCount;
}

void _favoriteCharacterSerialize(
  FavoriteCharacter object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.characterId);
  writer.writeString(offsets[1], object.characterJson);
}

FavoriteCharacter _favoriteCharacterDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FavoriteCharacter();
  object.characterId = reader.readString(offsets[0]);
  object.characterJson = reader.readString(offsets[1]);
  object.id = id;
  return object;
}

P _favoriteCharacterDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _favoriteCharacterGetId(FavoriteCharacter object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _favoriteCharacterGetLinks(
  FavoriteCharacter object,
) {
  return [];
}

void _favoriteCharacterAttach(
  IsarCollection<dynamic> col,
  Id id,
  FavoriteCharacter object,
) {
  object.id = id;
}

extension FavoriteCharacterByIndex on IsarCollection<FavoriteCharacter> {
  Future<FavoriteCharacter?> getByCharacterId(String characterId) {
    return getByIndex(r'characterId', [characterId]);
  }

  FavoriteCharacter? getByCharacterIdSync(String characterId) {
    return getByIndexSync(r'characterId', [characterId]);
  }

  Future<bool> deleteByCharacterId(String characterId) {
    return deleteByIndex(r'characterId', [characterId]);
  }

  bool deleteByCharacterIdSync(String characterId) {
    return deleteByIndexSync(r'characterId', [characterId]);
  }

  Future<List<FavoriteCharacter?>> getAllByCharacterId(
    List<String> characterIdValues,
  ) {
    final values = characterIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'characterId', values);
  }

  List<FavoriteCharacter?> getAllByCharacterIdSync(
    List<String> characterIdValues,
  ) {
    final values = characterIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'characterId', values);
  }

  Future<int> deleteAllByCharacterId(List<String> characterIdValues) {
    final values = characterIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'characterId', values);
  }

  int deleteAllByCharacterIdSync(List<String> characterIdValues) {
    final values = characterIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'characterId', values);
  }

  Future<Id> putByCharacterId(FavoriteCharacter object) {
    return putByIndex(r'characterId', object);
  }

  Id putByCharacterIdSync(FavoriteCharacter object, {bool saveLinks = true}) {
    return putByIndexSync(r'characterId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByCharacterId(List<FavoriteCharacter> objects) {
    return putAllByIndex(r'characterId', objects);
  }

  List<Id> putAllByCharacterIdSync(
    List<FavoriteCharacter> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'characterId', objects, saveLinks: saveLinks);
  }
}

extension FavoriteCharacterQueryWhereSort
    on QueryBuilder<FavoriteCharacter, FavoriteCharacter, QWhere> {
  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FavoriteCharacterQueryWhere
    on QueryBuilder<FavoriteCharacter, FavoriteCharacter, QWhereClause> {
  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterWhereClause>
  idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterWhereClause>
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterWhereClause>
  characterIdEqualTo(String characterId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'characterId',
          value: [characterId],
        ),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterWhereClause>
  characterIdNotEqualTo(String characterId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'characterId',
                lower: [],
                upper: [characterId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'characterId',
                lower: [characterId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'characterId',
                lower: [characterId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'characterId',
                lower: [],
                upper: [characterId],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension FavoriteCharacterQueryFilter
    on QueryBuilder<FavoriteCharacter, FavoriteCharacter, QFilterCondition> {
  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterFilterCondition>
  characterIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'characterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterFilterCondition>
  characterIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'characterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterFilterCondition>
  characterIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'characterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterFilterCondition>
  characterIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'characterId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterFilterCondition>
  characterIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'characterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterFilterCondition>
  characterIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'characterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterFilterCondition>
  characterIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'characterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterFilterCondition>
  characterIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'characterId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterFilterCondition>
  characterIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'characterId', value: ''),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterFilterCondition>
  characterIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'characterId', value: ''),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterFilterCondition>
  characterJsonEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'characterJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterFilterCondition>
  characterJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'characterJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterFilterCondition>
  characterJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'characterJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterFilterCondition>
  characterJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'characterJson',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterFilterCondition>
  characterJsonStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'characterJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterFilterCondition>
  characterJsonEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'characterJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterFilterCondition>
  characterJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'characterJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterFilterCondition>
  characterJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'characterJson',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterFilterCondition>
  characterJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'characterJson', value: ''),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterFilterCondition>
  characterJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'characterJson', value: ''),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterFilterCondition>
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension FavoriteCharacterQueryObject
    on QueryBuilder<FavoriteCharacter, FavoriteCharacter, QFilterCondition> {}

extension FavoriteCharacterQueryLinks
    on QueryBuilder<FavoriteCharacter, FavoriteCharacter, QFilterCondition> {}

extension FavoriteCharacterQuerySortBy
    on QueryBuilder<FavoriteCharacter, FavoriteCharacter, QSortBy> {
  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterSortBy>
  sortByCharacterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'characterId', Sort.asc);
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterSortBy>
  sortByCharacterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'characterId', Sort.desc);
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterSortBy>
  sortByCharacterJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'characterJson', Sort.asc);
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterSortBy>
  sortByCharacterJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'characterJson', Sort.desc);
    });
  }
}

extension FavoriteCharacterQuerySortThenBy
    on QueryBuilder<FavoriteCharacter, FavoriteCharacter, QSortThenBy> {
  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterSortBy>
  thenByCharacterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'characterId', Sort.asc);
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterSortBy>
  thenByCharacterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'characterId', Sort.desc);
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterSortBy>
  thenByCharacterJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'characterJson', Sort.asc);
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterSortBy>
  thenByCharacterJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'characterJson', Sort.desc);
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension FavoriteCharacterQueryWhereDistinct
    on QueryBuilder<FavoriteCharacter, FavoriteCharacter, QDistinct> {
  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QDistinct>
  distinctByCharacterId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'characterId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FavoriteCharacter, FavoriteCharacter, QDistinct>
  distinctByCharacterJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'characterJson',
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension FavoriteCharacterQueryProperty
    on QueryBuilder<FavoriteCharacter, FavoriteCharacter, QQueryProperty> {
  QueryBuilder<FavoriteCharacter, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FavoriteCharacter, String, QQueryOperations>
  characterIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'characterId');
    });
  }

  QueryBuilder<FavoriteCharacter, String, QQueryOperations>
  characterJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'characterJson');
    });
  }
}
