import 'package:digital_jeweller/features/admin/domain/entities/customer.dart';
import 'customer_model.dart';

class CustomerListResponseModel {
  final int responseStatus;
  final String responseMessage;
  final int count;
  final List<Customer> customers;

  CustomerListResponseModel({
    required this.responseStatus,
    required this.responseMessage,
    required this.count,
    required this.customers,
  });

  factory CustomerListResponseModel.fromJson(Map<String, dynamic> json) {
    final Object? container = json['responseData'] ?? json['data'] ?? json;
    final data = (container is Map<String, dynamic>)
        ? container
        : <String, dynamic>{};
    final customersRaw = data['customers'] ?? json['customers'] ?? <dynamic>[];
    final customersJson = customersRaw is List ? customersRaw : <dynamic>[];

    final parsedCustomers = customersJson.whereType<Map<String, dynamic>>().map(
      (e) {
        final model = CustomerModel.fromJson(e);
        return Customer(
          id: model.id,
          name: model.name,
          phone: model.phone,
          email: model.email ?? '',
          profileImage: model.profileImage,
          joinedDate: model.joinedDate,
        );
      },
    ).toList();

    return CustomerListResponseModel(
      responseStatus: json['responseStatus'] is int
          ? json['responseStatus'] as int
          : 0,
      responseMessage: (json['responseMessage'] ?? '').toString(),
      count: (data['count'] is int)
          ? data['count'] as int
          : customersJson.length,
      customers: parsedCustomers,
    );
  }
}
