import 'package:dio/dio.dart';
import 'package:io_mindtechapps_hw/core/utils/extensions/map_extension.dart';

Future<Dio> createHttpClient({
  required Future<String> Function() getBaseUrl,
  Future<String?> Function()? getTokenCallback,
  Map<String, String>? headers,
  Duration? timeout = const Duration(seconds: 120),
}) async {
  final usedHeaders = {'Content-Type': 'application/json', 'Accept': 'application/json'}.merge(headers);

  final client = Dio(
    BaseOptions(
      baseUrl: await getBaseUrl(),
      headers: usedHeaders,
      sendTimeout: timeout,
      receiveTimeout: timeout,
      connectTimeout: timeout,
      validateStatus: (status) {
        return status != null && status >= 200 && status < 500;
      },
    ),
  );

  // Add token interceptor. Otherwise, the client is not authenticated.
  if (getTokenCallback != null) {
    final wrapper = InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await getTokenCallback();

        if (token != null) options.headers.addAll({'Authorization': 'Bearer $token'});
        handler.next(options);
      },
    );

    client.interceptors.add(wrapper);
  }

  client.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.baseUrl = await getBaseUrl();

        handler.next(options);
      },
    ),
  );

  return client;
}
