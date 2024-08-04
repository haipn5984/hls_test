import 'dart:convert';
import 'dart:developer';

import 'package:jokee_single_serving/core/local/prefs.dart';
import 'package:jokee_single_serving/feature/joke/domain/entities/joke_model.dart';

abstract class JokeDataSource {
  Future<List<JokeModel>> getJoke();
  Future<bool> saveJoke(List<JokeModel> listJoke);
}

class JokeDataSourceImpl implements JokeDataSource {
  @override
  Future<List<JokeModel>> getJoke() async {
    try {
      final listJsonEncode = PrefsService.getReadJoke().split(';');
      return listJsonEncode
          .map(
            (e) => JokeModel.fromJson(
              jsonDecode(e),
            ),
          )
          .toList();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  @override
  Future<bool> saveJoke(List<JokeModel> listJoke) async {
    try {
      final decoded = listJoke.map((e) => jsonEncode(e.toJson())).toList();

      final str = decoded.join(';');

      return await PrefsService.saveReadJokeId(str);
    } catch (e) {
      return false;
    }
  }
}
