// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CharacterNotifier)
final characterProvider = CharacterNotifierProvider._();

final class CharacterNotifierProvider
    extends $NotifierProvider<CharacterNotifier, CharacterState> {
  CharacterNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'characterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$characterNotifierHash();

  @$internal
  @override
  CharacterNotifier create() => CharacterNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CharacterState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CharacterState>(value),
    );
  }
}

String _$characterNotifierHash() => r'2922053f5eda4eacdad324e483017fa1e4c8efe1';

abstract class _$CharacterNotifier extends $Notifier<CharacterState> {
  CharacterState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CharacterState, CharacterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CharacterState, CharacterState>,
              CharacterState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
