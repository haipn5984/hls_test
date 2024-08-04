import 'package:flutter/material.dart';
import 'package:jokee_single_serving/core/injection_container.dart';
import 'package:jokee_single_serving/core/local/prefs.dart';
import 'package:jokee_single_serving/feature/joke/presentation/joke_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsService.init();
  await singletonInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const JokePage(),
    );
  }
}
