import 'package:jokee_single_serving/core/usecases/usecase.dart';
import 'package:jokee_single_serving/feature/joke/data/repo/joke_repository.dart';
import 'package:jokee_single_serving/feature/joke/domain/entities/joke_model.dart';

class GetJokeUseCase implements UseCase<List<JokeModel>, NoParams> {
  final JokeRepository repository;

  GetJokeUseCase({required this.repository});
  @override
  Future<List<JokeModel>> call(
    NoParams params,
  ) async {
    return await repository.getJokes();
  }
}
