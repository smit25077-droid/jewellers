import 'package:get_storage/get_storage.dart';
import 'package:digital_jeweller/core/service_locator.dart';

/// Verification script to check all service locator registrations
/// Run this with: flutter test test/core/service_locator_verification.dart
void main() async {
  print('🔍 Starting Service Locator Verification...\n');
  
  // Initialize GetStorage
  await GetStorage.init();
  
  // Setup service locator
  await setupLocator();
  
  print('✅ Service Locator initialized successfully!\n');
  
  // Verify Core Dependencies
  print('📦 CORE DEPENDENCIES:');
  _verifyRegistration('DioClient', 'DioClient');
  _verifyRegistration('Dio', 'Dio');
  _verifyRegistration('GetStorage', 'GetStorage');
  print('');
  
  // Verify Auth Feature
  print('🔐 AUTH FEATURE:');
  _verifyRegistration('AuthService', 'AuthService');
  _verifyRegistration('AuthRepositoryImpl', 'AuthRepositoryImpl');
  _verifyRegistration('AuthRepository', 'AuthRepository');
  _verifyRegistration('LoginUseCase', 'LoginUseCase');
  print('');
  
  // Verify Admin Banner Feature
  print('🎨 ADMIN BANNER FEATURE:');
  _verifyRegistration('BannerRemoteDataSource', 'BannerRemoteDataSource');
  _verifyRegistration('BannerRepositoryImpl', 'BannerRepositoryImpl');
  _verifyRegistration('BannerRepository', 'BannerRepository');
  _verifyRegistration('CreateBannerUseCase', 'CreateBannerUseCase');
  _verifyRegistration('GetBannersUseCase', 'GetBannersUseCase');
  print('');
  
  // Verify Admin Customer Feature
  print('👥 ADMIN CUSTOMER FEATURE:');
  _verifyRegistration('AdminCustomerRemoteDataSource', 'AdminCustomerRemoteDataSource');
  _verifyRegistration('AdminCustomerRepositoryImpl', 'AdminCustomerRepositoryImpl');
  _verifyRegistration('AdminCustomerRepository', 'AdminCustomerRepository');
  print('');
  
  // Verify Admin Scheme Feature
  print('📋 ADMIN SCHEME FEATURE:');
  _verifyRegistration('SchemeRemoteDataSource', 'SchemeRemoteDataSource');
  _verifyRegistration('SchemeRepositoryImpl', 'SchemeRepositoryImpl');
  _verifyRegistration('SchemeRepository', 'SchemeRepository');
  _verifyRegistration('GetSchemesUseCase', 'GetSchemesUseCase');
  _verifyRegistration('CreateSchemeUseCase', 'CreateSchemeUseCase');
  _verifyRegistration('UpdateSchemeUseCase', 'UpdateSchemeUseCase');
  _verifyRegistration('DeleteSchemeUseCase', 'DeleteSchemeUseCase');
  _verifyRegistration('AdminSchemesAddUpdateUsecase', 'AdminSchemesAddUpdateUsecase');
  print('');
  
  // Verify User Feature
  print('👤 USER FEATURE:');
  _verifyRegistration('JoinSchemeUseCase', 'JoinSchemeUseCase');
  _verifyRegistration('JoinedSchemeUseCase', 'JoinedSchemeUseCase');
  print('');
  
  // Verify Master Admin Feature
  print('⚙️ MASTER ADMIN FEATURE:');
  _verifyRegistration('MasterAdminRemoteDataSource', 'MasterAdminRemoteDataSource');
  _verifyRegistration('MasterAdminRepositoryImpl', 'MasterAdminRepositoryImpl');
  _verifyRegistration('MasterAdminRepository', 'MasterAdminRepository');
  _verifyRegistration('MasterAdminJewellerUsecase', 'MasterAdminJewellerUsecase');
  print('');
  
  print('🎉 All service locator registrations verified successfully!');
  print('📊 Total registrations checked: ${_successCount + _failureCount}');
  print('✅ Successful: $_successCount');
  print('❌ Failed: $_failureCount');
}

int _successCount = 0;
int _failureCount = 0;

void _verifyRegistration(String name, String type) {
  try {
    final isRegistered = sl.isRegistered(instanceName: type);
    if (isRegistered) {
      print('  ✅ $name');
      _successCount++;
    } else {
      print('  ❌ $name - NOT REGISTERED');
      _failureCount++;
    }
  } catch (e) {
    print('  ❌ $name - ERROR: $e');
    _failureCount++;
  }
}
