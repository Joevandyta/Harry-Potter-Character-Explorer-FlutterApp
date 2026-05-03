import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:harry_potter_char_app/src/core/network_providers.dart';
import 'package:harry_potter_char_app/src/data/datasource/remote_datasource.dart';
import 'package:harry_potter_char_app/src/data/repository/repository_impl.dart';
import 'package:harry_potter_char_app/src/domain/repository/repository.dart';

part 'character_providers.g.dart';

@riverpod
RemoteDataSource remoteDataSource(RemoteDataSourceRef ref) {
  return RemoteDataSource(dio: ref.watch(dioProvider));
}

@riverpod
Repository repository(RepositoryRef ref) {
  return RepositoryImpl(remoteDataSource: ref.watch(remoteDataSourceProvider));
}
