import 'session_config.dart';

class SessionConfigBuilder {
  String? _configName;
  String Function(Object?)? _userToJson;
  Object? Function(String)? _userFromJson;

  SessionConfigBuilder userSerializer({
    required String Function(Object?) toJson,
    required Object? Function(String) fromJson,
  }) {
    _userToJson = toJson;
    _userFromJson = fromJson;
    return this;
  }

  SessionConfigBuilder name(String name) {
    _configName = name;
    return this;
  }

  SessionConfig build() {
    if (_configName == null || _configName!.isEmpty) {
      throw ArgumentError('configName is required');
    }
    return SessionConfig(configName: _configName!, userToJson: _userToJson, userFromJson: _userFromJson);
  }
}
