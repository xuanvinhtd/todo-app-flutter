import 'package:getx_todo/src/app/config/app_env.dart';

class AppConfig {
  final AppEnv env;
  final bool isStub;
  final bool isTestMode;

  AppConfig(this.env, {this.isStub = false, this.isTestMode = false});

  factory AppConfig.dev({bool isTestMode = false}) {
    return AppConfig(AppEnv.dev, isTestMode: isTestMode);
  }
  factory AppConfig.stg() {
    return AppConfig(AppEnv.dev);
  }
  factory AppConfig.prod() {
    return AppConfig(AppEnv.prod);
  }
}
