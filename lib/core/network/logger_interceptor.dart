import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _log(
      'REQUEST[${options.method}]',
      url: options.uri.toString(),
      headers: options.headers,
      body: options.data,
    );
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _log(
      'RESPONSE[${response.statusCode}]',
      url: response.requestOptions.uri.toString(),
      response: response,
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log(
      'ERROR[${err.response?.statusCode}]',
      url: err.requestOptions.uri.toString(),
      error: err.message,
      response: err.response,
    );
    return super.onError(err, handler);
  }

  static void _log(
    String title, {
    String? url,
    Map<String, dynamic>? headers,
    dynamic body,
    Response? response,
    dynamic error,
  }) {
    if (!kDebugMode) return;

    debugPrint('╔${'═' * 80}');
    debugPrint('║  API LOG: $title');
    debugPrint('╠${'═' * 80}');
    if (url != null) debugPrint('║  URL: $url');
    if (headers != null && headers.isNotEmpty) {
      debugPrint('║  Headers: $headers');
    }

    if (body != null) {
      try {
        final prettyBody = const JsonEncoder.withIndent('  ').convert(body);
        debugPrint('║  Body:');
        prettyBody.split('\n').forEach((line) => debugPrint('║    $line'));
      } catch (_) {
        debugPrint('║  Body: $body');
      }
    }

    if (response != null) {
      if (body == null) debugPrint('╠${'═' * 80}');
      debugPrint('║  Status Code: ${response.statusCode}');
      try {
        final decoded = response.data is String
            ? jsonDecode(response.data)
            : response.data;
        final prettyResponse = const JsonEncoder.withIndent(
          '  ',
        ).convert(decoded);
        debugPrint('║  Response Body:');
        prettyResponse.split('\n').forEach((line) => debugPrint('║    $line'));
      } catch (_) {
        debugPrint('║  Response Body: ${response.data}');
      }
    }

    if (error != null) {
      debugPrint('╠${'═' * 80}');
      debugPrint('║ ⚠️ ERROR: $error');
    }
    debugPrint('╚${'═' * 80}');
  }
}
