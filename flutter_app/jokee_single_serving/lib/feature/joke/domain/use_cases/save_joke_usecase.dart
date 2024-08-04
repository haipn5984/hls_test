import 'package:jokee_single_serving/core/usecases/usecase.dart';
import 'package:jokee_single_serving/feature/joke/data/repo/joke_repository.dart';
import 'package:jokee_single_serving/feature/joke/domain/entities/joke_model.dart';

class SaveJokeUseCase implements UseCase<bool, List<JokeModel>> {
  final JokeRepository repository;

  SaveJokeUseCase({required this.repository});
  @override
  Future<bool> call(
    List<JokeModel> params,
  ) async {
    return await repository.saveJokes(params);
  }
}
