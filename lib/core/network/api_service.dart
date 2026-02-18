import 'package:dio/dio.dart';
import '../constants/api_endpoints.dart';
import 'dio_client.dart';

/// Base API Service class
/// Extend this class in your feature-specific data services
class ApiService {
  final DioClient _dioClient = DioClient.instance;

  /// GET request
  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    bool showLoading = false,
    String? loadingMessage,
  }) async {
    return await _dioClient.get(
      endpoint,
      queryParameters: queryParameters,
      showLoading: showLoading,
      loadingMessage: loadingMessage,
    );
  }

  /// POST request
  Future<Response> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool showLoading = false,
    String? loadingMessage,
  }) async {
    return await _dioClient.post(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      showLoading: showLoading,
      loadingMessage: loadingMessage,
    );
  }

  /// PUT request
  Future<Response> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool showLoading = false,
    String? loadingMessage,
  }) async {
    return await _dioClient.put(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      showLoading: showLoading,
      loadingMessage: loadingMessage,
    );
  }

  /// DELETE request
  Future<Response> delete(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool showLoading = false,
    String? loadingMessage,
  }) async {
    return await _dioClient.delete(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      showLoading: showLoading,
      loadingMessage: loadingMessage,
    );
  }

  /// PATCH request
  Future<Response> patch(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool showLoading = false,
    String? loadingMessage,
  }) async {
    return await _dioClient.patch(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      showLoading: showLoading,
      loadingMessage: loadingMessage,
    );
  }
}

/// Example: Auth API Service
class AuthApiService extends ApiService {
  Future<Response> login(String email, String password) async {
    return await post(
      ApiEndpoints.login,
      data: {
        'email': email,
        'password': password,
      },
    );
  }

  Future<Response> register(Map<String, dynamic> userData) async {
    return await post(
      ApiEndpoints.register,
      data: userData,
    );
  }

  Future<Response> logout() async {
    return await post(
      ApiEndpoints.logout,
    );
  }
}

/// Example: User API Service
class UserApiService extends ApiService {
  Future<Response> getUserProfile() async {
    return await get(
      ApiEndpoints.userProfile,
    );
  }

  Future<Response> updateProfile(Map<String, dynamic> data) async {
    return await put(
      ApiEndpoints.updateProfile,
      data: data,
    );
  }
}

/// Example: Product API Service
class ProductApiService extends ApiService {
  Future<Response> getProducts({Map<String, dynamic>? filters}) async {
    return await get(
      ApiEndpoints.products,
      queryParameters: filters,
    );
  }

  Future<Response> getProductById(String id) async {
    return await get(
      ApiEndpoints.withId(ApiEndpoints.productDetails, id),
    );
  }

  Future<Response> createProduct(Map<String, dynamic> data) async {
    return await post(
      ApiEndpoints.createProduct,
      data: data,
    );
  }

  Future<Response> updateProduct(String id, Map<String, dynamic> data) async {
    return await put(
      ApiEndpoints.withId(ApiEndpoints.updateProduct, id),
      data: data,
    );
  }

  Future<Response> deleteProduct(String id) async {
    return await delete(
      ApiEndpoints.withId(ApiEndpoints.deleteProduct, id),
    );
  }
}
