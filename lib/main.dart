import 'package:flutter/material.dart';
import 'package:ourdeen/features/counter/presentation/views/counter_view.dart';

import 'features/shared/providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Providers(
      child: MaterialApp(
        title: 'Ourdeen DDD MVVM',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const CounterView(),
      ),
    );
  }
}