import 'package:digital_jeweller/features/master_admin/domain/usecases/master_admin_jeweller_usecase.dart';
import 'package:digital_jeweller/features/user/domain/usecases/joined_scheme_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

// Core
import 'network/dio_client.dart';

// Auth
import '../features/auth/data/datasources/auth_service.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/login_usecase.dart';

// Admin - Banners
import 'package:digital_jeweller/features/admin/data/data_sources/banner_remote_data_source.dart';
import 'package:digital_jeweller/features/admin/data/repositories/banner_repository_impl.dart';
import 'package:digital_jeweller/features/admin/domain/repositories/banner_repository.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/create_banner_use_case.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/get_banners_use_case.dart';

// Admin - Customers
import '../features/admin/data/datasources/admin_customer_remote_data_source.dart';
import '../features/admin/data/repositories/admin_customer_repository_impl.dart';
import '../features/admin/domain/repositories/admin_customer_repository.dart';

// Admin - Schemes
import '../features/admin/data/datasources/scheme_remote_datasource.dart';
import '../features/admin/data/repositories/scheme_repository_impl.dart';
import '../features/admin/domain/repositories/scheme_repository.dart';
import '../features/admin/domain/usecases/get_schemes_usecase.dart';
import '../features/admin/domain/usecases/create_scheme_usecase.dart';
import '../features/admin/domain/usecases/update_scheme_usecase.dart';
import '../features/admin/domain/usecases/delete_scheme_usecase.dart';
import '../features/admin/domain/usecases/admin_schemes_add_update_usecase.dart';
import '../features/user/domain/usecases/join_scheme_use_case.dart';

// Master Admin - Jeweller Management
import '../features/master_admin/jeweller_management/data/services/jeweller_service.dart';
import '../features/master_admin/jeweller_management/data/repositories/jeweller_repository_impl.dart';
import '../features/master_admin/jeweller_management/domain/repositories/jeweller_repository.dart';
import '../features/master_admin/jeweller_management/domain/usecases/get_jewellers_usecase.dart';
import '../features/master_admin/jeweller_management/domain/usecases/create_jeweller_usecase.dart';
import '../features/master_admin/jeweller_management/domain/usecases/delete_jeweller_usecase.dart';
import '../features/master_admin/jeweller_management/domain/usecases/toggle_jeweller_status_usecase.dart';

// Master Admin - Legacy (to be removed)
import '../features/master_admin/data/data_service/master_admin_service.dart';
import '../features/master_admin/data/repositories/master_admin_repository_impl.dart';
import '../features/master_admin/domain/repositories/master_admin_repository.dart';

final GetIt sl = GetIt.instance;

Future<void> setupLocator() async {
  // ============================================
  // CORE - Network & Storage
  // ============================================

  // DioClient singleton
  sl.registerLazySingleton<DioClient>(() => DioClient.instance);

  // Dio instance
  sl.registerLazySingleton<Dio>(() => sl<DioClient>().dio);

  // GetStorage
  sl.registerLazySingleton<GetStorage>(() => GetStorage());

  // ============================================
  // DATA SOURCES
  // ============================================

  sl.registerLazySingleton<AuthService>(() => AuthServiceImpl());

  sl.registerLazySingleton<BannerRemoteDataSource>(
    () => BannerRemoteDataSourceImpl(dio: sl<Dio>(), storage: sl<GetStorage>()),
  );

  sl.registerLazySingleton<AdminCustomerRemoteDataSource>(() => AdminCustomerRemoteDataSource());

  sl.registerLazySingleton<SchemeRemoteDataSource>(() => SchemeRemoteDataSourceImpl(dio: sl<Dio>()));

  // Jeweller Management Service
  sl.registerLazySingleton<JewellerService>(
    () => JewellerServiceImpl(dioClient: sl<DioClient>()),
  );

  // Legacy Master Admin Data Source (to be removed)
  sl.registerLazySingleton<MasterAdminRemoteDataSource>(() => MasterAdminRemoteDataSourceImpl());

  // ============================================
  // REPOSITORIES
  // ============================================

  // Auth Repository
  sl.registerLazySingleton<AuthRepositoryImpl>(() => AuthRepositoryImpl(/*authService: sl<AuthService>()*/));
  sl.registerLazySingleton<AuthRepository>(() => sl<AuthRepositoryImpl>());

  // Banner Repository
  sl.registerLazySingleton<BannerRepositoryImpl>(
    () => BannerRepositoryImpl(remoteDataSource: sl<BannerRemoteDataSource>()),
  );
  sl.registerLazySingleton<BannerRepository>(() => sl<BannerRepositoryImpl>());

  // Admin Customer Repository
  sl.registerLazySingleton<AdminCustomerRepositoryImpl>(
    () => AdminCustomerRepositoryImpl(dataSource: sl<AdminCustomerRemoteDataSource>()),
  );
  sl.registerLazySingleton<AdminCustomerRepository>(() => sl<AdminCustomerRepositoryImpl>());

  // Scheme Repository
  sl.registerLazySingleton<SchemeRepositoryImpl>(
    () => SchemeRepositoryImpl(remoteDataSource: sl<SchemeRemoteDataSource>()),
  );
  sl.registerLazySingleton<SchemeRepository>(() => sl<SchemeRepositoryImpl>());

  // Jeweller Repository
  sl.registerLazySingleton<JewellerRepositoryImpl>(
    () => JewellerRepositoryImpl(service: sl<JewellerService>()),
  );
  sl.registerLazySingleton<JewellerRepository>(() => sl<JewellerRepositoryImpl>());

  // Legacy Master Admin Repository (to be removed)
  sl.registerLazySingleton<MasterAdminRepositoryImpl>(
    () => MasterAdminRepositoryImpl(remoteDataSource: sl<MasterAdminRemoteDataSource>()),
  );
  sl.registerLazySingleton<MasterAdminRepository>(() => sl<MasterAdminRepositoryImpl>());

  // ============================================
  // USE CASES
  // ============================================

  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => CreateBannerUseCase(sl<BannerRepository>()));
  sl.registerLazySingleton(() => GetBannersUseCase(sl<BannerRepository>()));
  sl.registerLazySingleton(() => GetSchemesUseCase(sl<SchemeRepository>()));
  sl.registerLazySingleton(() => CreateSchemeUseCase(sl<SchemeRepository>()));
  sl.registerLazySingleton(() => UpdateSchemeUseCase(sl<SchemeRepository>()));
  sl.registerLazySingleton(() => DeleteSchemeUseCase(sl<SchemeRepository>()));
  sl.registerLazySingleton(() => JoinSchemeUseCase(repository: sl<SchemeRepository>()));
  sl.registerLazySingleton(() => JoinedSchemeUseCase(repository: sl<SchemeRepository>()));
  sl.registerLazySingleton(() => AdminSchemesAddUpdateUsecase(sl<SchemeRepository>()));
  
  // Jeweller Management Use Cases
  sl.registerLazySingleton(() => GetJewellersUseCase(repository: sl<JewellerRepository>()));
  sl.registerLazySingleton(() => CreateJewellerUseCase(repository: sl<JewellerRepository>()));
  sl.registerLazySingleton(() => DeleteJewellerUseCase(repository: sl<JewellerRepository>()));
  sl.registerLazySingleton(() => ToggleJewellerStatusUseCase(repository: sl<JewellerRepository>()));
  
  // Legacy Master Admin Use Case (to be removed)
  sl.registerLazySingleton(() => MasterAdminJewellerUsecase());
}

/// Get a dependency from service locator
T getIt<T extends Object>() => sl<T>();
