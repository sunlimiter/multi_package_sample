class SessionConfig {
  final String configName;

  final String Function(Object? user)? userToJson;

  final Object? Function(String json)? userFromJson;

  const SessionConfig({required this.configName, this.userToJson, this.userFromJson});
}
