import 'package:jokee_single_serving/feature/joke/domain/entities/joke_model.dart';

abstract class JokeRepository {
  Future<List<JokeModel>> getJokes();

  Future<bool> saveJokes(List<JokeModel> listJoke);
}
