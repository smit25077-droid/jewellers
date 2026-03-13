import 'package:digital_jeweller/core/constants/api_endpoints.dart';
import 'package:digital_jeweller/core/error/exceptions.dart';
import 'package:digital_jeweller/features/admin/data/models/jeweller_dashboard_model.dart';
import 'package:dio/dio.dart';

abstract class JewellerDashboardDataSource {
  Future<JewellerDashboardModel> getDashboard();
  Future jewellerWinner() ;
}

class JewellerDashboardDataSourceImpl implements JewellerDashboardDataSource {
  final Dio dio;

  JewellerDashboardDataSourceImpl({required this.dio});

  @override
  Future<JewellerDashboardModel> getDashboard() async {
    try {
      final response = await dio.get(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.jewellerDashboard}',
      );
      final responseData = response.data['responseData'];
      if (responseData != null) {
        return JewellerDashboardModel.fromJson(responseData);
      } else {
        throw ServerException(message: 'Invalid response format from server.');
      }
    } on DioException catch (e) {
      throw ServerException(
        message:
            e.response?.data['responseMessage'] ??
            e.message ??
            'Failed to fetch jeweller dashboard.',
      );
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future jewellerWinner() async {
    try {
      final response = await dio.get(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getDrawWinnerSchemes}',
      );
      final responseData = response.data['responseData'];
      if (responseData != null) {
        return JewellerDashboardModel.fromJson(responseData);
      } else {
        throw ServerException(message: 'Invalid response format from server.');
      }
    } on DioException catch (e) {
      throw ServerException(
        message:
        e.response?.data['responseMessage'] ??
            e.message ??
            'Failed to fetch jeweller dashboard.',
      );
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }  }
}
