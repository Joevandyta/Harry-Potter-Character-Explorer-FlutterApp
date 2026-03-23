import 'package:get_it/get_it.dart';
import 'package:harry_potter_char_app/core/network/api_client.dart';
import 'package:harry_potter_char_app/data/datasource/remote_datasource.dart';
import 'package:harry_potter_char_app/domain/repository/repository.dart';
import 'package:harry_potter_char_app/presentation/character_bloc/character_bloc.dart';

import '../data/repository/repository_impl.dart';

var getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton(ApiClient());
  getIt.registerSingleton(getIt<ApiClient>().getDio());
  getIt.registerLazySingleton(() => RemoteDataSource(dio: getIt()));
  getIt.registerLazySingleton<Repository>(
    () => RepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerFactory(()=> CharacterBloc(repository: getIt()));
}
