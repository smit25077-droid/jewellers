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
    print('🔍 CustomerListResponseModel: Starting JSON parsing...');
    print('🔍 Raw JSON keys: ${json.keys.toList()}');

    // Try to locate the object that actually contains the customers array
    final Object? container = json['responseData'] ?? json['data'] ?? json;

    print('🔍 Container type: ${container.runtimeType}');

    final data = (container is Map<String, dynamic>)
        ? container
        : <String, dynamic>{};

    print('🔍 Data keys: ${data.keys.toList()}');

    final customersRaw = data['customers'] ?? json['customers'] ?? <dynamic>[];

    print('🔍 CustomersRaw type: ${customersRaw.runtimeType}');
    print(
      '🔍 CustomersRaw length: ${customersRaw is List ? customersRaw.length : 0}',
    );

    final customersJson = customersRaw is List ? customersRaw : <dynamic>[];

    print('🔍 CustomersJson length: ${customersJson.length}');

    final parsedCustomers = customersJson
        .whereType<Map<String, dynamic>>()
        .map(CustomerModel.fromJson)
        .toList();

    print('✅ Parsed ${parsedCustomers.length} customers');

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
