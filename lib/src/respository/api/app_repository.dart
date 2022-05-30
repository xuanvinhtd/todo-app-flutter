import 'package:getx_todo/src/app/config/app_constant.dart';
import 'package:getx_todo/src/common/base/network/api_provider.dart';
import 'package:getx_todo/src/common/base/network/api_response.dart';

class AppRepository {
  AppRepository(this._apiProvider);
  final APIProvider _apiProvider;

  Future<ResponseData> getTodoData() async {
    try {
      final result = await _apiProvider.get(
        AppConstant.TODO,
      );
      return ResponseData.success(
        [],
        response: result,
      );
    } catch (e) {
      return ResponseData.error(e);
    }
  }
}
