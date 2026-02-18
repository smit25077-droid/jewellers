import '../entities/customer.dart';

abstract class AdminCustomerRepository {
  Future<List<Customer>> getCustomers();

  Future<Customer> getCustomerById(String id);

  Future<Customer> createCustomer({
    required String name,
    required String phone,
    required String email,
    required String password,
  });

  Future<Customer> updateCustomer({
    required String id,
    required String name,
    required String mobile,
    required String email,
  });

  Future<void> deleteCustomer(String id);
}

