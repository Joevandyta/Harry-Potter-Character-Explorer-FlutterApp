// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localDataSource)
final localDataSourceProvider = LocalDataSourceProvider._();

final class LocalDataSourceProvider
    extends
        $FunctionalProvider<LocalDataSource, LocalDataSource, LocalDataSource>
    with $Provider<LocalDataSource> {
  LocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localDataSourceHash();

  @$internal
  @override
  $ProviderElement<LocalDataSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LocalDataSource create(Ref ref) {
    return localDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalDataSource>(value),
    );
  }
}

String _$localDataSourceHash() => r'81f739813cd8a73501a0e1698d325272366ac66b';

@ProviderFor(remoteDataSource)
final remoteDataSourceProvider = RemoteDataSourceProvider._();

final class RemoteDataSourceProvider
    extends
        $FunctionalProvider<
          RemoteDataSource,
          RemoteDataSource,
          RemoteDataSource
        >
    with $Provider<RemoteDataSource> {
  RemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<RemoteDataSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RemoteDataSource create(Ref ref) {
    return remoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemoteDataSource>(value),
    );
  }
}

String _$remoteDataSourceHash() => r'e8219a373ffce198c4bc82bc2c8b52f6a9913099';

@ProviderFor(repository)
final repositoryProvider = RepositoryProvider._();

final class RepositoryProvider
    extends $FunctionalProvider<Repository, Repository, Repository>
    with $Provider<Repository> {
  RepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'repositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$repositoryHash();

  @$internal
  @override
  $ProviderElement<Repository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Repository create(Ref ref) {
    return repository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Repository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Repository>(value),
    );
  }
}

String _$repositoryHash() => r'f9944edb05999466172a3931043d5a043ace49c9';
