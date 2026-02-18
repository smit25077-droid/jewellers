import 'package:dio/dio.dart';
import 'package:digital_jeweller/core/network/dio_client.dart';
import '../../domain/entities/jeweller.dart';
import '../models/jeweller_model.dart';
import '../models/jeweller_list_response_model.dart';

abstract class MasterAdminRemoteDataSource {
  Future<List<Jeweller>> getJewellers();
  Future<Jeweller> createJeweller(Jeweller jeweller);
  Future deleteJeweller(String id);
  Future<Jeweller> toggleJewellerStatus(String id, bool isActive);
}

class MasterAdminRemoteDataSourceImpl implements MasterAdminRemoteDataSource {
  final DioClient dioClient;

  MasterAdminRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<Jeweller>> getJewellers() async {
    try {
      final response = await dioClient.get('/jewellers');

      if (response.statusCode == 200) {
        final data =
            response.data['responseData'] as Map<String, dynamic>? ?? {};
        final listResponse = JewellerListResponseModel.fromJson(data);
        return listResponse.jewellers;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to fetch jewellers',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Jeweller> createJeweller(Jeweller jeweller) async {
    try {
      final model = JewellerModel(
        name: jeweller.name,
        address: jeweller.address,
        phone: jeweller.phone,
        email: jeweller.email,
        jewellerCode: jeweller.jewellerCode,
        password: jeweller.password,
        panNumber: jeweller.panNumber,
        aadhaarNumber: jeweller.aadhaarNumber,
        gstNumber: jeweller.gstNumber,
        id: '',
      );

      final response = await dioClient.post('/jewellers', data: model.toJson());

      if (response.statusCode == 201) {
        final data = response.data['responseData']['jeweller'];
        return JewellerModel.fromJson(data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to create jeweller',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future deleteJeweller(String id) async {
    try {
      final response = await dioClient.delete('/jewellers/$id');
      if (response.statusCode == 200) {
        final data = response.data['responseMessage'];
        return data;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to delete jeweller',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Jeweller> toggleJewellerStatus(String id, bool isActive) async {
    try {
      final response = await dioClient.put(
        '/jewellers/$id',
        data: {'isActive': isActive},
      );

      if (response.statusCode == 200) {
        final data = response.data['responseData']['jeweller'];
        return JewellerModel.fromJson(data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to update jeweller status',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
