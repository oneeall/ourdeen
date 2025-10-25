import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:motor/motor.dart';
import 'package:ourdeen/features/memorizing/presentation/views/memorizing_view.dart';

import 'core/theme/theme.dart';
import 'core/theme/util.dart';
import 'features/shared/providers.dart';
import 'features/shared/widgets/floating_bar_action_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(
      context,
      "Noto Sans Anatolian Hieroglyphs",
      "Noto Sans Anatolian Hieroglyphs",
    );
    MaterialTheme theme = MaterialTheme(textTheme);
    return Providers(
      child: MaterialApp(
        title: 'Ourdeen DDD MVVM',
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        home: const MemorizingView(),
        // home: Counter2Page(),
      ),
    );
  }
}