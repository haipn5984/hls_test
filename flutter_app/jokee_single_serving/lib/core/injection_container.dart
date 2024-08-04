import 'package:get_it/get_it.dart';
import 'package:jokee_single_serving/feature/joke/di_joke.dart';

final getItInstance = GetIt.instance;

Future<void> singletonInit() async {
  await dependencyInjectionsJoke(getItInstance);
}
