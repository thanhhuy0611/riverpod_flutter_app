import 'package:flutter_app_riverpod/provider_examples/state_notifier_provider/theme_notifier.dart';
import 'package:flutter_app_riverpod/provider_examples/state_notifier_provider/theme_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// example StateNotifierProvider
final themeProvider = StateNotifierProvider.autoDispose<ThemeNotifier, ThemeState>((ref) {
  ref.onDispose(() {
    // this code will be execute before this provider is dispose
  });
  return ThemeNotifier();
});