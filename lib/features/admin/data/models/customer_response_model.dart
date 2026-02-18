import 'customer_model.dart';

class CustomerResponseModel {
  final int responseStatus;
  final String responseMessage;
  final CustomerModel customer;

  CustomerResponseModel({
    required this.responseStatus,
    required this.responseMessage,
    required this.customer,
  });

  factory CustomerResponseModel.fromJson(Map<String, dynamic> json) {
    final data = (json['responseData'] ?? {}) as Map<String, dynamic>;

    return CustomerResponseModel(
      responseStatus: json['responseStatus'] as int? ?? 0,
      responseMessage: (json['responseMessage'] ?? '').toString(),
      customer: CustomerModel.fromJson(data),
    );
  }
}

