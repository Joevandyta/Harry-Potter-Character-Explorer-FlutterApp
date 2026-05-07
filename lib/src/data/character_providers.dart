import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:harry_potter_char_app/src/core/network_providers.dart';
import 'package:harry_potter_char_app/src/data/datasource/remote_datasource.dart';
import 'package:harry_potter_char_app/src/data/datasource/local_datasource.dart';
import 'package:harry_potter_char_app/src/data/repository/repository_impl.dart';
import 'package:harry_potter_char_app/src/domain/repository/repository.dart';
import 'package:isar_community/isar.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'character_providers.g.dart';

final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError('isarProvider must be overridden');
});

@riverpod
LocalDataSource localDataSource(Ref ref) {
  return LocalDataSource(isar: ref.watch(isarProvider));
}

@riverpod
RemoteDataSource remoteDataSource(Ref ref) {
  return RemoteDataSource(dio: ref.watch(dioProvider));
}

@riverpod
Repository repository(Ref ref) {
  return RepositoryImpl(
    remoteDataSource: ref.watch(remoteDataSourceProvider),
    localDataSource: ref.watch(localDataSourceProvider),
  );
}
