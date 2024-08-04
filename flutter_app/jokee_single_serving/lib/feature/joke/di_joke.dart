import 'package:get_it/get_it.dart';
import 'package:jokee_single_serving/feature/joke/data/data_source/joke_data_source.dart';
import 'package:jokee_single_serving/feature/joke/data/repo/joke_repository.dart';
import 'package:jokee_single_serving/feature/joke/data/repo/joke_repository_impl.dart';
import 'package:jokee_single_serving/feature/joke/domain/use_cases/get_joke_usecase.dart';
import 'package:jokee_single_serving/feature/joke/domain/use_cases/save_joke_usecase.dart';

Future<void> dependencyInjectionsJoke(GetIt getIt) async {
  getIt.registerLazySingleton<JokeDataSource>(
    () => JokeDataSourceImpl(),
  );

  getIt.registerLazySingleton<JokeRepository>(
    () => JokeReposisotyImpl(),
  );

  getIt.registerLazySingleton(
    () => GetJokeUseCase(
      repository: getIt.get(),
    ),
  );

  getIt.registerLazySingleton(
    () => SaveJokeUseCase(
      repository: getIt.get(),
    ),
  );
}
