import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jokee_single_serving/feature/joke/presentation/bloc/joke_bloc.dart';
import 'package:jokee_single_serving/feature/joke/presentation/content/joke_main.dart';

class JokePage extends StatelessWidget {
  const JokePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JokeBloc()
        ..add(
          const JokeEvent.fetched(),
        ),
      child: const JokeMain(),
    );
  }
}
