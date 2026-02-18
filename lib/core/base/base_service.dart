import 'package:digital_jeweller/core/network/dio_client.dart';
import 'package:digital_jeweller/core/service_locator.dart';
import 'package:dio/dio.dart';
import '../error/exceptions.dart';

/// Base Service class for all API services
/// Provides common HTTP methods with error handling
abstract class BaseService {
  /// GET request with error handling
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool showLoading = false,
    String? loadingMessage,
  }) async {
    try {
      return await sl<DioClient>().get(
        path,
        queryParameters: queryParameters,
        options: options,
        showLoading: showLoading,
        loadingMessage: loadingMessage,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: 'Unexpected error: $e');
    }
  }

  /// POST request with error handling
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool showLoading = false,
    String? loadingMessage,
  }) async {
    try {
      return await sl<DioClient>().post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        showLoading: showLoading,
        loadingMessage: loadingMessage,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: 'Unexpected error: $e');
    }
  }

  /// PUT request with error handling
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool showLoading = false,
    String? loadingMessage,
  }) async {
    try {
      return await sl<DioClient>().put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        showLoading: showLoading,
        loadingMessage: loadingMessage,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: 'Unexpected error: $e');
    }
  }

  /// DELETE request with error handling
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool showLoading = false,
    String? loadingMessage,
  }) async {
    try {
      return await sl<DioClient>().delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        showLoading: showLoading,
        loadingMessage: loadingMessage,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: 'Unexpected error: $e');
    }
  }

  /// PATCH request with error handling
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool showLoading = false,
    String? loadingMessage,
  }) async {
    try {
      return await sl<DioClient>().patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        showLoading: showLoading,
        loadingMessage: loadingMessage,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: 'Unexpected error: $e');
    }
  }

  /// Handle Dio errors and convert to custom exceptions
  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          message: 'Connection timeout. Please try again.',
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message =
            error.response?.data['message'] ??
            error.response?.data['error'] ??
            _getStatusCodeMessage(statusCode);
        return ServerException(message: message, statusCode: statusCode);

      case DioExceptionType.cancel:
        return ServerException(message: 'Request cancelled');

      case DioExceptionType.connectionError:
        return NetworkException(message: 'No internet connection');

      default:
        return ServerException(message: 'Unexpected error occurred');
    }
  }

  /// Get user-friendly message for status codes
  String _getStatusCodeMessage(int? statusCode) {
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
