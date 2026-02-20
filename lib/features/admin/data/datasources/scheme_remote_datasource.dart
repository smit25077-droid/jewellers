import 'package:digital_jeweller/core/constants/api_endpoints.dart';
import 'package:digital_jeweller/core/error/exceptions.dart';
import 'package:digital_jeweller/features/admin/data/models/scheme_model.dart';
import 'package:digital_jeweller/features/user/data/models/joined_scheme_model.dart';
import 'package:dio/dio.dart';

abstract class SchemeRemoteDataSource {
  Future<List<SchemeModel>> getSchemes();

  Future<SchemeModel> createScheme({
    required String name,
    required String description,
    required double totalAmount,
    required double emiAmount,
    required String jewellerCode,
    required int durationMonths,
    required String startDate,
    required String endDate,
  });

  Future<SchemeModel> updateScheme({
    required String id,
    Map<String, dynamic>? updateData,
  });

  Future<void> deleteScheme(String id);
  Future<void> joinScheme(String schemeId);
  Future<List<JoinedSchemeModel>> getJoinedSchemes();
}

class SchemeRemoteDataSourceImpl implements SchemeRemoteDataSource {
  final Dio dio;

  SchemeRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<SchemeModel>> getSchemes() async {
    try {
      final response = await dio.get('${ApiEndpoints.baseUrl}/schemes');
      final responseData = response.data['responseData'];
      if (responseData != null && responseData['schemes'] is List) {
        return (responseData['schemes'] as List)
            .map((schemeJson) => SchemeModel.fromJson(schemeJson))
            .toList();
      } else {
        throw ServerException(message: 'Invalid response format from server.');
      }
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to fetch schemes.');
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<SchemeModel> createScheme({
    required String name,
    required String description,
    required double totalAmount,
    required double emiAmount,
    required String jewellerCode,
    required int durationMonths,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final response = await dio.post(
        '${ApiEndpoints.baseUrl}/schemes',
        data: {
          "name": name,
          "description": description,
          "totalAmount": totalAmount,
          "emiAmount": emiAmount,
          "jewellerCode": jewellerCode,
          "durationMonths": durationMonths,
          "startDate": startDate,
          "endDate": endDate,
        },
      );
      final responseData = response.data['responseData'];
      if (responseData != null) {
        return SchemeModel.fromJson(responseData);
      } else {
        throw ServerException(message: 'Invalid response format from server.');
      }
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to create scheme.');
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<SchemeModel> updateScheme({
    required String id,
    Map<String, dynamic>? updateData,
  }) async {
    try {
      final response = await dio.put(
        '${ApiEndpoints.baseUrl}/schemes/$id',
        data: updateData,
      );
      final responseData = response.data['responseData'];
      if (responseData != null) {
        return SchemeModel.fromJson(responseData);
      } else {
        throw ServerException(message: 'Invalid response format from server.');
      }
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to update scheme.');
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteScheme(String id) async {
    try {
      await dio.delete('${ApiEndpoints.baseUrl}/schemes/$id');
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Failed to delete scheme.');
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<void> joinScheme(String schemeId) async {
    try {
      final response = await dio.post(
        '${ApiEndpoints.joinScheme}/$schemeId/join',
      );
      if (response.statusCode != 201 && response.statusCode != 200) {
        throw ServerException(
          message: response.data['responseMessage'] ?? 'Failed to join scheme.',
        );
      }
    } on DioException catch (e) {
      throw ServerException(
        message:
            e.response?.data['responseMessage'] ??
            e.message ??
            'Failed to join scheme.',
      );
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<List<JoinedSchemeModel>> getJoinedSchemes() async {
    try {
      final response = await dio.get(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getJoinedSchemes}',
      );
      final responseData = response.data['responseData'];
      if (responseData != null && responseData['enrollments'] is List) {
        return (responseData['enrollments'] as List)
            .map((e) => JoinedSchemeModel.fromJson(e))
            .toList();
      } else {
        throw ServerException(message: 'Invalid response format from server.');
      }
    } on DioException catch (e) {
      throw ServerException(
        message:
            e.response?.data['responseMessage'] ??
            e.message ??
            'Failed to fetch joined schemes.',
      );
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }
}
