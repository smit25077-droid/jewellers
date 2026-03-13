import 'package:digital_jeweller/core/constants/api_endpoints.dart';
import 'package:digital_jeweller/core/error/exceptions.dart';
import 'package:digital_jeweller/features/user/data/models/customer_dashboard_model.dart';
import 'package:dio/dio.dart';

abstract class CustomerDashboardDataSource {
  Future<CustomerDashboardModel> getDashboard();
}

class CustomerDashboardDataSourceImpl implements CustomerDashboardDataSource {
  final Dio dio;

  CustomerDashboardDataSourceImpl({required this.dio});

  @override
  Future<CustomerDashboardModel> getDashboard() async {
    try {
      final response = await dio.get(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.customerDashboard}',
      );
      final responseData = response.data['responseData'];
      if (responseData != null) {
        return CustomerDashboardModel.fromJson(
          responseData as Map<String, dynamic>,
        );
      } else {
        throw ServerException(message: 'Invalid response format from server.');
      }
    } on DioException catch (e) {
      throw ServerException(
        message:
            e.response?.data['responseMessage'] ??
            e.message ??
            'Failed to fetch customer dashboard.',
      );
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }
}
