import 'package:componentized/environments/app_build_config.dart';
import 'package:componentized/environments/app_start.dart';

///author: lty
///Time: 2022/06/10
///Description:

class App extends AppStart {
  App() : super(AppBuildConfig());
}

Future<void> main() => App().startApp();
