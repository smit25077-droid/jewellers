import 'package:flutter/cupertino.dart';

import 'customer_model.dart';

class CustomerListResponseModel {
  final int responseStatus;
  final String responseMessage;
  final int count;
  final List<CustomerModel> customers;

  CustomerListResponseModel({
    required this.responseStatus,
    required this.responseMessage,
    required this.count,
    required this.customers,
  });

  /// Parses list response in a defensive way so minor backend
  /// envelope changes don't break the app.
  ///
  /// It supports all of these shapes:
  /// {
  ///   "responseStatus": 200,
  ///   "responseMessage": "...",
  ///   "responseData": {
  ///     "count": 3,
  ///     "customers": [ ... ]
  ///   }
  /// }
  ///
  /// {
  ///   "count": 3,
  ///   "customers": [ ... ]
  /// }
  ///
  /// {
  ///   "data": {
  ///     "count": 3,
  ///     "customers": [ ... ]
  ///   }
  /// }
  factory CustomerListResponseModel.fromJson(Map<String, dynamic> json) {
    debugPrint('🔍 CustomerListResponseModel: Starting JSON parsing...');
    debugPrint('🔍 Raw JSON keys: ${json.keys.toList()}');

    // Try to locate the object that actually contains the customers array
    final Object? container = json['responseData'] ?? json['data'] ?? json;

    debugPrint('🔍 Container type: ${container.runtimeType}');

    final data = (container is Map<String, dynamic>)
        ? container
        : <String, dynamic>{};

    debugPrint('🔍 Data keys: ${data.keys.toList()}');

    final customersRaw = data['customers'] ?? json['customers'] ?? <dynamic>[];

    debugPrint('🔍 CustomersRaw type: ${customersRaw.runtimeType}');
    debugPrint(
      '🔍 CustomersRaw length: ${customersRaw is List ? customersRaw.length : 0}',
    );

    final customersJson = customersRaw is List ? customersRaw : <dynamic>[];

    debugPrint('🔍 CustomersJson length: ${customersJson.length}');

    final parsedCustomers = customersJson
        .whereType<Map<String, dynamic>>()
        .map(CustomerModel.fromJson)
        .toList();

    debugPrint('✅ Parsed ${parsedCustomers.length} customers');

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
