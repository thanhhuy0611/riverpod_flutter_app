class ThemeState {
  final bool isDarkMode;
  final bool isIOS;

  ThemeState({this.isDarkMode = true, required this.isIOS});

  ThemeState copyWith({
    bool? isDarkMode,
    bool? isIOS,
  }) {
    return ThemeState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isIOS: isIOS ?? this.isIOS,
    );
  }
}