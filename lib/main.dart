import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_riverpod/get_it.dart';
import 'package:flutter_app_riverpod/provider_examples/change_notifier_provider/big_counter_model.dart';
import 'package:flutter_app_riverpod/provider_examples/change_notifier_provider/big_counter_provider.dart';
import 'package:flutter_app_riverpod/provider_examples/future_provider/username_provider.dart';
import 'package:flutter_app_riverpod/provider_examples/state_notifier_provider/theme_notifier.dart';
import 'package:flutter_app_riverpod/provider_examples/state_notifier_provider/theme_provider.dart';
import 'package:flutter_app_riverpod/repository/user_data_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'provider_examples/provider/greeting_provider.dart';
import 'provider_examples/state_provider/counter_provider.dart';

void main() {
  configureDependencies();
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
    int valueCounter = ref.watch(counterProvider.state).state;

    // ChangeNotifierProvider example
    final BigCounterModel bigCounterModel = ref.watch(bigCounterModelProvider);
    final int valueBigCounter = bigCounterModel.value;
    
    // StateNotifier example
    final themeState = ref.watch(themeProvider);
    final primaryColor = themeState.isDarkMode ? Colors.black : Colors.red;
    
    // GetIt example
    final userRepo = getIt.get<UserDataRepository>();
    // FutureProvider example
    final AsyncValue<Either<String, HttpException>> response = ref.watch(usernameProvider(userRepo));
    
    final Widget usernameWidget = response.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (response) {
        return response.fold(
          (username) => Text(username),
          (httpError) => Text('Error: $httpError'),
        );
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
                onPressed: () => ref.read(counterProvider.state).state++,
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