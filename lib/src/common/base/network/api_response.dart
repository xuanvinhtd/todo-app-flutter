import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

enum Status { SUCCESS, ERROR, INVALID_PAGE_NUMBER_ERROR, CANCEL, NO_INTERNET, TIMEOUT, CLIENT_ERROR, SERVER_ERROR, UNKNOWN }

extension StatusExts on Status {
  String get message {
    switch (this) {
      case Status.SUCCESS:
        return 'Xữ lý Thành công!';
      case Status.ERROR:
        return 'Đã có lỗi xảy ra, vui lòng thử lại sau!';
      case Status.INVALID_PAGE_NUMBER_ERROR:
        return 'Số trang không hợp lệ!';
      case Status.CANCEL:
        return 'Huỷ xữ lý';
      case Status.NO_INTERNET:
        return 'Không có kết nối mạng, vui lòng kiểm tra mạng của bạn!';
      case Status.TIMEOUT:
        return 'Thời gian xữ lý quá lâu, vui lòng thử lại sau!';
      case Status.CLIENT_ERROR:
        return 'Đã có lỗi xảy ra, vui lòng kiểm tra thông tin của bạn và thử lại!';
      case Status.SERVER_ERROR:
        return 'Máy chủ đang gặp vấn đề nào đó, vui lòng thử lại sau!';
      case Status.UNKNOWN:
        return 'Không xác định';
    }
  }
}

class ResponseData<T> {
  Status? status;
  T? data;
  String? message = '';

  bool isSuccess() {
    return status == Status.SUCCESS;
  }

  ResponseData.success(this.data, {dynamic response}) {
    status = Status.SUCCESS;
    if (response is Map<String, dynamic>) {
      final statusCode = response['statusCode'];
      if (statusCode != null) {
        status = _mapCodeToState(statusCode);
        message = response['message'] ?? response['error'];
      }
    }

    message = message?.isEmpty == true ? status?.message : message;
  }
  ResponseData.error(dynamic error) {
    if (error is DioError || error is DioErrorType) {
      status = _mapErrorToState(error);
      try {
        final json = jsonDecode(error?.response.toString() ?? '');
        if (json == null) {
          message = status?.message;
        } else {
          message = json['message'].toString();
          message = message == 'null' ? json['error'].toString() : message;
        }
      } catch (e) {
        message = status?.message;
      }
    } else {
      status = Status.ERROR;
      message = error.toString();
    }
  }

  Status _mapCodeToState(int code) {
    if (code >= 200 && code <= 299) {
      return Status.SUCCESS;
    }
    if (code >= 400 && code <= 499) {
      return Status.CLIENT_ERROR;
    }
    if (code >= 500 && code >= 599) {
      return Status.SERVER_ERROR;
    }
    return Status.UNKNOWN;
  }

  Status _mapErrorToState(dynamic error) {
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          return Status.CANCEL;
        case DioErrorType.connectTimeout:
          return Status.TIMEOUT;
        case DioErrorType.other:
          return Status.NO_INTERNET;
        case DioErrorType.receiveTimeout:
          return Status.TIMEOUT;
        case DioErrorType.response:
          if (error.error is SocketException) {
            return Status.NO_INTERNET;
          }
          switch (error.response?.statusCode) {
            case 400:
              return Status.INVALID_PAGE_NUMBER_ERROR;
            default:
              return Status.ERROR;
          }
        case DioErrorType.sendTimeout:
          return Status.TIMEOUT;
      }
    } else if (error is SocketException) {
      return Status.NO_INTERNET;
    }
    return Status.ERROR;
  }

  @override
  String toString() {
    return 'Status : $status \n Message : $message \n Data : $data';
  }
}
