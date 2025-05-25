import 'package:dio/dio.dart';

extension HttpExtension on Response {
  bool get isSuccessStatusCode {
    if (statusCode == null) {
      return false;
    }

    return statusCode! >= 200 && statusCode! <= 299;
  }
}
