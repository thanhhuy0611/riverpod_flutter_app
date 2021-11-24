import 'dart:io';

import 'package:flutter_app_riverpod/provider_examples/state_notifier_provider/theme_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier(): super(ThemeState(isDarkMode: true, isIOS: Platform.isIOS));
  
  toggleDarkMode() {
    final isDarkMode = state.isDarkMode;
    state = state.copyWith(isDarkMode: !isDarkMode);
  }
}