import '../../entities/customer.dart';

abstract class CustomerRepository {
  Future<List<Customer>> getCustomers();
  Future<Customer> getCustomerById(String id);
  Future<void> addCustomer(Map<String, dynamic> customerData);
  Future<void> updateCustomer(String id, Map<String, dynamic> customerData);
  Future<void> deleteCustomer(String id);
}
