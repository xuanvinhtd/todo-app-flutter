import 'package:getx_todo/src/app/config/app_constant.dart';

enum AppEnv { dev, prod, stg }

extension AppEnvExt on AppEnv {
  bool get isDev {
    return this == AppEnv.dev;
  }

  bool get isStg {
    return this == AppEnv.stg;
  }

  bool get isProd {
    return this == AppEnv.prod;
  }

  String get baseUrl {
    switch (this) {
      case AppEnv.dev:
        return AppConstant.DEV_BASE_URL;
      case AppEnv.stg:
        return AppConstant.STG_BASE_URL;
      case AppEnv.prod:
        return AppConstant.PRO_BASE_URL;
    }
  }

  String get appName {
    switch (this) {
      case AppEnv.dev:
        return AppConstant.DEV_APP_NAME;
      case AppEnv.stg:
        return AppConstant.STG_APP_NAME;
      case AppEnv.prod:
        return AppConstant.PRO_APP_NAME;
    }
  }
}
