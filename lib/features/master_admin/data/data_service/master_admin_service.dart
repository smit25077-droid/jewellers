import 'package:digital_jeweller/core/service_locator.dart';
import 'package:dio/dio.dart';
import 'package:digital_jeweller/core/network/dio_client.dart';
import '../../jeweller/domain/entities/jeweller.dart';
import '../models/jeweller_model.dart';
import '../models/jeweller_list_response_model.dart';

abstract class MasterAdminRemoteDataSource {
  Future<List<Jeweller>> getJewellers();
  Future<Jeweller> createJeweller(Jeweller jeweller);
  Future deleteJeweller(String id);
  Future<Jeweller> toggleJewellerStatus(String id, bool isActive);
}

class MasterAdminRemoteDataSourceImpl implements MasterAdminRemoteDataSource {
  // final DioClient dioClient;

  MasterAdminRemoteDataSourceImpl(/*{required this.dioClient}*/);

  final dioClient = sl<DioClient>();
  @override
  Future<List<Jeweller>> getJewellers() async {
    try {
      final response = await dioClient.get('/jewellers');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data =
            response.data['responseData'] as Map<String, dynamic>? ?? {};
        JewellerListResponseModel listResponse =
            JewellerListResponseModel.fromJson(data);
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
      final fields = <String, dynamic>{
        'name': jeweller.name,
        'address': jeweller.address,
        'phone': jeweller.phone,
        'email': jeweller.email,
        'jewellerCode': jeweller.jewellerCode,
        if (jeweller.password != null) 'password': jeweller.password,
        'panNumber': jeweller.panNumber,
        'aadhaarNumber': jeweller.aadhaarNumber,
        'gstNumber': jeweller.gstNumber,
      };

      if (jeweller.logo != null &&
          jeweller.logo!.isNotEmpty &&
          !jeweller.logo!.startsWith('http')) {
        fields['logo'] = await MultipartFile.fromFile(
          jeweller.logo!,
          filename: jeweller.logo!.split('/').last,
        );
      }

      final response = await dioClient.post(
        '/jewellers',
        data: FormData.fromMap(fields),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
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
      if (response.statusCode == 200 || response.statusCode == 201) {
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

      if (response.statusCode == 200 || response.statusCode == 201) {
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
