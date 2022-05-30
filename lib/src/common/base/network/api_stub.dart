import 'dart:typed_data';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:getx_todo/src/app/config/app_constant.dart';
import 'package:getx_todo/src/data/mock/todo_list.dart';

const int responseDelayTime = 1;

class StubDio extends HttpClientAdapter {
  final DefaultHttpClientAdapter _adapter = DefaultHttpClientAdapter();

  @override
  Future<ResponseBody> fetch(RequestOptions options, Stream<Uint8List>? requestStream, Future? cancelFuture) async {
    final lastPath = '/${options.uri.pathSegments.last}';
    switch (lastPath) {
      case AppConstant.TODO:
        return await Future.delayed(const Duration(seconds: responseDelayTime), () {
          return ResponseBody.fromString(todos, 200);
        });
      default:
        return _adapter.fetch(options, requestStream, cancelFuture);
    }
  }

  @override
  void close({bool force = false}) {
    _adapter.close(force: force);
  }
}
