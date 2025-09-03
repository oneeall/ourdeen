import 'package:flutter/material.dart';
import 'package:ourdeen/core/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:ourdeen/features/counter/presentation/viewmodels/counter_viewmodel.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CounterViewModel>(context);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
          /// create function sum
          
            SliverAppBar(
              title: const Text('DDD MVVM Counter'),
              snap: true,
              floating: true,
            ),
          ];
        },
      body: Scaffold(
        body: Center(
          child: ListTile(
            title: Text(
              "قَالَ اجْعَلْنِيْ عَلٰى خَزَاۤىِٕنِ الْاَرْضِۚ اِنِّيْ حَفِيْظٌ عَلِيْمٌ",
              style: MaterialTheme.arabicTextStyle,
            ),
            subtitle: Text(
              "qâlaj‘alnî ‘alâ khazâ'inil-ardl, innî ḫafîdhun ‘alîm",
              style: MaterialTheme.accessibleBodyStyle,
            ),
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.isBusy ? null : viewModel.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    )));
    return Scaffold(
      appBar: AppBar(title: const Text('DDD MVVM Counter')),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       if (viewModel.isBusy && viewModel.counter == null)
      //         const CircularProgressIndicator()
      //       else
      //         Text(
      //           '${viewModel.counter?.value ?? 0}',
      //           style: Theme.of(context).textTheme.headlineMedium,
      //         ),
      //       if (viewModel.isBusy && viewModel.counter != null)
      //         const Padding(
      //           padding: EdgeInsets.all(8.0),
      //           child: Text('Updating...'),
      //         ),
      //     ],
      //   ),
      // ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemBuilder: (context, index) {
          return Card(child: Center(child: Text('Item $index')));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.isBusy ? null : viewModel.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
