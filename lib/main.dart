import 'package:flutter/material.dart';
import 'package:flutter_app_riverpod/provider_examples/change_notifier_provider/big_counter_model.dart';
import 'package:flutter_app_riverpod/provider_examples/change_notifier_provider/big_counter_provider.dart';
import 'package:flutter_app_riverpod/provider_examples/future_provider/username_provider.dart';
import 'package:flutter_app_riverpod/provider_examples/state_notifier_provider/theme_notifier.dart';
import 'package:flutter_app_riverpod/provider_examples/state_notifier_provider/theme_provider.dart';
import 'package:flutter_app_riverpod/provider_examples/state_notifier_provider/theme_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'provider_examples/provider/greeting_provider.dart';
import 'provider_examples/state_provider/counter_provider.dart';

void main() {
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    const ProviderScope(
      child: HomeScreen(),
    ),
  );
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Provider example
    final String greeting = ref.watch(greetingProvider);

    // StateProvider example
    final int valueCounter = ref.watch(counterProvider);

    // ChangeNotifierProvider example
    final BigCounterModel bigCounterModel = ref.watch(bigCounterModelProvider);
    final int valueBigCounter = bigCounterModel.value;
    
    // StateNotifier example
    final ThemeState themeState = ref.watch(themeProvider);
    final primaryColor = themeState.isDarkMode ? Colors.black : Colors.red;
    
    // FutureProvider example
    final AsyncValue<String> usernameAsyncValue = ref.watch(usernameProvider);
    final Widget usernameWidget = usernameAsyncValue.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (username) {
        return Text(username);
      },
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(greeting),
          backgroundColor: primaryColor,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              usernameWidget,

              Text(valueCounter.toString(),
                style: const TextStyle(fontSize: 20),
              ),
              
              Text(valueBigCounter.toString(), 
                style: const TextStyle(fontSize: 40),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // BigCounter button
              FloatingActionButton(
                backgroundColor: primaryColor,
                onPressed: () => bigCounterModel.increase(),
                child: const Icon(Icons.add, size: 56,),
              ),
              // Counter button
              FloatingActionButton(
                backgroundColor: primaryColor,
                onPressed: () => ref.read<StateController<int>>(counterProvider.state).state++,
                child: const Icon(Icons.add),
              ),
              // Theme button
              FloatingActionButton(
                backgroundColor: primaryColor,
                onPressed: () => ref.read<ThemeNotifier>(themeProvider.notifier).toggleDarkMode(),
                child: const Icon(Icons.lightbulb),
              )
            ],
          ),
        ),
      ),
    );
  }
}