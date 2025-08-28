import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ourdeen/features/counter/presentation/viewmodels/counter_viewmodel.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CounterViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DDD MVVM Counter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            if (viewModel.isBusy && viewModel.counter == null)
              const CircularProgressIndicator()
            else
              Text(
                '${viewModel.counter?.value ?? 0}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            if (viewModel.isBusy && viewModel.counter != null)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Updating...'),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.isBusy ? null : viewModel.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}