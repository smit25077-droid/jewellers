import 'package:dio/dio.dart';
import 'package:digital_jeweller/core/network/dio_client.dart';
import '../models/jeweller_model.dart';
import 'package:digital_jeweller/features/master_admin/jeweller/domain/entities/jeweller.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';

abstract class JewellerService {
  Future<List<Jeweller>> getJewellers();
  Future<Jeweller> createJeweller(Jeweller jeweller);
  Future<String> deleteJeweller(String id);
  Future<Jeweller> toggleJewellerStatus(String id, bool isActive);
  Future<Jeweller> updateJeweller(Jeweller jeweller);
}

class JewellerServiceImpl implements JewellerService {
  final DioClient dioClient;

  JewellerServiceImpl({required this.dioClient});

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
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '/jewellers'),
        error: 'Unexpected error: $e',
      );
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

      dynamic data;
      if (jeweller.logo != null &&
          !jeweller.logo!.startsWith('http') &&
          !jeweller.logo!.startsWith('https')) {
        if (kIsWeb) {
          final XFile file = XFile(jeweller.logo!);
          final bytes = await file.readAsBytes();
          data = FormData.fromMap({
            ...model.toJson(),
            'logo': MultipartFile.fromBytes(
              bytes,
              filename: file.name,
            ),
          });
        } else {
          data = FormData.fromMap({
            ...model.toJson(),
            'logo': await MultipartFile.fromFile(
              jeweller.logo!,
              filename: jeweller.logo!.split('/').last,
            ),
          });
        }
      } else {
        data = model.toJson();
      }

      final response = await dioClient.post('/jewellers', data: data);

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
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '/jewellers'),
        error: 'Unexpected error: $e',
      );
    }
  }

  @override
  Future<String> deleteJeweller(String id) async {
    try {
      final response = await dioClient.delete('/jewellers/$id');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final message =
            response.data['responseMessage'] ?? 'Jeweller deleted successfully';
        return message.toString();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to delete jeweller',
        );
      }
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '/jewellers/$id'),
        error: 'Unexpected error: $e',
      );
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
        // API returns jeweller data directly in responseData, not nested
        final data = response.data['responseData'];
        return JewellerModel.fromJson(data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to update jeweller status',
        );
      }
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '/jewellers/$id'),
        error: 'Unexpected error: $e',
      );
    }
  }

  @override
  Future<Jeweller> updateJeweller(Jeweller jeweller) async {
    try {
      final model = JewellerModel(
        id: jeweller.id,
        name: jeweller.name,
        address: jeweller.address,
        phone: jeweller.phone,
        email: jeweller.email,
        jewellerCode: jeweller.jewellerCode,
        panNumber: jeweller.panNumber,
        aadhaarNumber: jeweller.aadhaarNumber,
        gstNumber: jeweller.gstNumber,
        isActive: jeweller.isActive,
      );

      dynamic data;
      if (jeweller.logo != null &&
          jeweller.logo!.isNotEmpty &&
          !jeweller.logo!.startsWith('http') &&
          !jeweller.logo!.startsWith('https')) {
        if (kIsWeb) {
          final XFile file = XFile(jeweller.logo!);
          final bytes = await file.readAsBytes();
          data = FormData.fromMap({
            ...model.toJson(),
            'logo': MultipartFile.fromBytes(
              bytes,
              filename: file.name,
            ),
          });
        } else {
          data = FormData.fromMap({
            ...model.toJson(),
            'logo': await MultipartFile.fromFile(
              jeweller.logo!,
              filename: jeweller.logo!.split('/').last,
            ),
          });
        }
      } else {
        data = model.toJson();
      }

      final response = await dioClient.put(
        '/jewellers/${jeweller.id}',
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // API returns jeweller data directly in responseData, not nested
        final data = response.data['responseData'];
        return JewellerModel.fromJson(data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to update jeweller',
        );
      }
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '/jewellers/${jeweller.id}'),
        error: 'Unexpected error: $e',
      );
    }
  }
}
