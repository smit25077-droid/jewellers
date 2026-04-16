import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'logger_interceptor.dart';
import '../constants/api_endpoints.dart';
import '../utils/loading_overlay.dart';
import '../utils/snackbar_utils.dart';

/// Dio HTTP Client with interceptors and error handling
class DioClient {
  static DioClient? _instance;
  late Dio _dio;
  final GetStorage _storage = GetStorage();

  DioClient._() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: ApiEndpoints.connectTimeout,
        receiveTimeout: ApiEndpoints.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _storage.read('token');
          // Don't add token for login or register endpoints
          bool isAuthRequest = options.path.contains('login') || options.path.contains('register');
          
          if (token != null && !isAuthRequest) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          _handleError(error);
          return handler.next(error);
        },
      ),
      LoggerInterceptor(),
    ]);
  }

  static DioClient get instance {
    _instance ??= DioClient._();
    return _instance!;
  }

  Dio get dio => _dio;

  /// GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool showLoading = false,
    String? loadingMessage,
  }) async {
    if (showLoading) LoadingOverlay.show(message: loadingMessage);
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } finally {
      if (showLoading) LoadingOverlay.hide();
    }
  }

  /// POST request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool showLoading = false,
    String? loadingMessage,
  }) async {
    if (showLoading) LoadingOverlay.show(message: loadingMessage);
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } finally {
      if (showLoading) LoadingOverlay.hide();
    }
  }

  /// PUT request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool showLoading = false,
    String? loadingMessage,
  }) async {
    if (showLoading) LoadingOverlay.show(message: loadingMessage);
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } finally {
      if (showLoading) LoadingOverlay.hide();
    }
  }

  /// DELETE request
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool showLoading = false,
    String? loadingMessage,
  }) async {
    if (showLoading) LoadingOverlay.show(message: loadingMessage);
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } finally {
      if (showLoading) LoadingOverlay.hide();
    }
  }

  /// PATCH request
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool showLoading = false,
    String? loadingMessage,
  }) async {
    if (showLoading) LoadingOverlay.show(message: loadingMessage);
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } finally {
      if (showLoading) LoadingOverlay.hide();
    }
  }

  /// Handle errors
  void _handleError(DioException error) {
    String errorMessage = 'Something went wrong';

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Connection timeout. Please try again.';
        break;
      case DioExceptionType.badResponse:
        errorMessage = _handleStatusCode(error.response?.statusCode);
        break;
      case DioExceptionType.cancel:
        errorMessage = 'Request cancelled';
        break;
      case DioExceptionType.connectionError:
        errorMessage = 'No internet connection';
        break;
      default:
        errorMessage = 'Unexpected error occurred';
    }

    // Show error using centralized utility
    debugPrint('API Error: $errorMessage');
    SnackBarUtils.showError(errorMessage);
  }

  String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized. Please login again.';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not found';
      case 500:
        return 'Internal server error';
      case 503:
        return 'Service unavailable';
      default:
        return 'Something went wrong';
    }
  }
}
