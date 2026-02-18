import 'package:digital_jeweller/features/admin/domain/entities/customer.dart';

import 'customer_model.dart';

class CustomerResponseModel {
  final int responseStatus;
  final String responseMessage;
  final Customer customer;

  CustomerResponseModel({
    required this.responseStatus,
    required this.responseMessage,
    required this.customer,
  });

  factory CustomerResponseModel.fromJson(Map<String, dynamic> json) {
    final Object? container = json['responseData'] ?? json['data'] ?? json;
    final data = (container is Map<String, dynamic>)
        ? container
        : <String, dynamic>{};

    // Some APIs might put the customer directly in the root or inside 'customer' key
    final customerJson = data['customer'] ?? data;
    final model = CustomerModel.fromJson(customerJson as Map<String, dynamic>);

    return CustomerResponseModel(
      responseStatus: json['responseStatus'] is int
          ? json['responseStatus'] as int
          : 0,
      responseMessage: (json['responseMessage'] ?? '').toString(),
      customer: Customer(
        id: model.id,
        name: model.name,
        phone: model.phone,
        email: model.email ?? '',
        profileImage: model.profileImage,
        joinedDate: model.joinedDate,
      ),
    );
  }
}
