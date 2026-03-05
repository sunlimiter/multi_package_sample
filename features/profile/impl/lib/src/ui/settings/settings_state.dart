class SettingsState {
  final bool isLoggingOut;
  final String? error;

  const SettingsState({this.isLoggingOut = false, this.error});

  SettingsState copyWith({bool? isLoggingOut, String? error}) {
    return SettingsState(isLoggingOut: isLoggingOut ?? this.isLoggingOut, error: error ?? this.error);
  }
}
