// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_characters_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FavoriteCharactersNotifier)
final favoriteCharactersProvider = FavoriteCharactersNotifierProvider._();

final class FavoriteCharactersNotifierProvider
    extends
        $AsyncNotifierProvider<
          FavoriteCharactersNotifier,
          List<CharacterModel>
        > {
  FavoriteCharactersNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoriteCharactersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoriteCharactersNotifierHash();

  @$internal
  @override
  FavoriteCharactersNotifier create() => FavoriteCharactersNotifier();
}

String _$favoriteCharactersNotifierHash() =>
    r'b771dac82a7d83a973c73c8c24ff8e683e350338';

abstract class _$FavoriteCharactersNotifier
    extends $AsyncNotifier<List<CharacterModel>> {
  FutureOr<List<CharacterModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<CharacterModel>>, List<CharacterModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<CharacterModel>>,
                List<CharacterModel>
              >,
              AsyncValue<List<CharacterModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(isFavorite)
final isFavoriteProvider = IsFavoriteFamily._();

final class IsFavoriteProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  IsFavoriteProvider._({
    required IsFavoriteFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'isFavoriteProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$isFavoriteHash();

  @override
  String toString() {
    return r'isFavoriteProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as String;
    return isFavorite(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is IsFavoriteProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$isFavoriteHash() => r'77639feaa7cd87ec1970801b0c472917c271dab9';

final class IsFavoriteFamily extends $Family
    with $FunctionalFamilyOverride<bool, String> {
  IsFavoriteFamily._()
    : super(
        retry: null,
        name: r'isFavoriteProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  IsFavoriteProvider call(String characterId) =>
      IsFavoriteProvider._(argument: characterId, from: this);

  @override
  String toString() => r'isFavoriteProvider';
}
