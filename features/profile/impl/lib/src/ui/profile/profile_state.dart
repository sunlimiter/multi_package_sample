class ProfileState {
  final bool isLoading;
  final String? error;

  const ProfileState({this.isLoading = false, this.error});

  ProfileState copyWith({bool? isLoading, String? error}) {
    return ProfileState(isLoading: isLoading ?? this.isLoading, error: error ?? this.error);
  }
}
