import 'package:dio/dio.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/constants/api_endpoints.dart';

/// Master Admin Remote Data Source
/// Example of how to use the common API service
class MasterAdminRemoteDataSource extends ApiService {
  
  /// Get dashboard statistics
  Future<Response> getDashboardStats() async {
    return await get(
      ApiEndpoints.dashboard,
    );
  }

  /// Get all users
  Future<Response> getAllUsers({
    int page = 1,
    int limit = 10,
    String? search,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    
    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }

    return await get(
      ApiEndpoints.getAllUsers,
      queryParameters: queryParams,
    );
  }

  /// Create new user
  Future<Response> createUser(Map<String, dynamic> userData) async {
    return await post(
      ApiEndpoints.createUser,
      data: userData,
    );
  }

  /// Update user
  Future<Response> updateUser(String userId, Map<String, dynamic> userData) async {
    return await put(
      ApiEndpoints.withId(ApiEndpoints.updateUser, userId),
      data: userData,
    );
  }

  /// Delete user
  Future<Response> deleteUser(String userId) async {
    return await delete(
      ApiEndpoints.withId(ApiEndpoints.deleteUser, userId),
    );
  }

  /// Get all admins
  Future<Response> getAllAdmins() async {
    return await get(
      ApiEndpoints.getAdmins,
    );
  }
}
