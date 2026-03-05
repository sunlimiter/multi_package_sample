import 'package:injectable/injectable.dart';
import 'package:network/network.dart';

import '../config/app_config.dart';

@Singleton(as: NetworkParams)
class AppNetworkParams implements NetworkParams {
  final AppConfig _appConfig;

  AppNetworkParams(this._appConfig);

  @override
  String get baseUrl => _appConfig.baseUrl();

  @override
  int get connectTimeout => 30000;

  @override
  int get receiveTimeout => 30000;
}
