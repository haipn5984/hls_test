import 'package:jokee_single_serving/core/injection_container.dart';
import 'package:jokee_single_serving/feature/joke/data/data_source/joke_data_source.dart';
import 'package:jokee_single_serving/feature/joke/data/repo/joke_repository.dart';
import 'package:jokee_single_serving/feature/joke/domain/entities/joke_model.dart';

class JokeReposisotyImpl implements JokeRepository {
  final JokeDataSource _dataSource = getItInstance.get();
  @override
  Future<List<JokeModel>> getJokes() async {
    return _dataSource.getJoke();
  }

  @override
  Future<bool> saveJokes(List<JokeModel> listJoke) {
    return _dataSource.saveJoke(listJoke);
  }
}
