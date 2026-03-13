import 'package:digital_jeweller/features/auth/presentation/controllers/auth_controller.dart';
import 'package:digital_jeweller/features/master_admin/domain/usecases/master_admin_jeweller_usecase.dart';
import 'package:digital_jeweller/features/user/domain/usecases/joined_scheme_use_case.dart';
import 'package:digital_jeweller/features/user/data/datasources/customer_dashboard_datasource.dart';
import 'package:digital_jeweller/features/user/data/repositories/customer_dashboard_repository_impl.dart';
import 'package:digital_jeweller/features/user/domain/repositories/customer_dashboard_repository.dart';
import 'package:digital_jeweller/features/user/domain/usecases/get_customer_dashboard_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

// Core
import 'package:digital_jeweller/core/network/dio_client.dart';

// Auth
import 'package:digital_jeweller/features/auth/login/data/services/login_service.dart';
import 'package:digital_jeweller/features/auth/login/data/repositories/login_repository_impl.dart';
import 'package:digital_jeweller/features/auth/login/domain/repositories/login_repository.dart';
import 'package:digital_jeweller/features/auth/login/domain/usecases/login_usecase.dart';
import 'package:digital_jeweller/features/auth/data/services/auth_service.dart' as auth_svc;
import 'package:digital_jeweller/features/auth/data/datasources/auth_service.dart' as auth_ds;
import 'package:digital_jeweller/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:digital_jeweller/features/auth/domain/repositories/auth_repository.dart';

// Admin - Banners
import 'package:digital_jeweller/features/admin/banner/data/services/banner_service.dart';
import 'package:digital_jeweller/features/admin/banner/data/repositories/banner_repository_impl.dart';
import 'package:digital_jeweller/features/admin/banner/domain/repositories/banner_repository.dart';
import 'package:digital_jeweller/features/admin/banner/domain/usecases/create_banner_usecase.dart';
import 'package:digital_jeweller/features/admin/banner/domain/usecases/get_banners_usecase.dart';

// Admin - Customers
import 'package:digital_jeweller/features/admin/data/datasources/admin_customer_remote_data_source.dart';
import 'package:digital_jeweller/features/admin/data/repositories/admin_customer_repository_impl.dart';
import 'package:digital_jeweller/features/admin/domain/repositories/admin_customer_repository.dart';

// Admin - Schemes
import 'package:digital_jeweller/features/admin/data/datasources/scheme_remote_datasource.dart';
import 'package:digital_jeweller/features/admin/data/repositories/scheme_repository_impl.dart';
import 'package:digital_jeweller/features/admin/domain/repositories/scheme_repository.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/get_schemes_usecase.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/create_scheme_usecase.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/update_scheme_usecase.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/delete_scheme_usecase.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/admin_schemes_add_update_usecase.dart';
import 'package:digital_jeweller/features/user/domain/usecases/join_scheme_use_case.dart';

// Admin - Jeweller Dashboard
import 'package:digital_jeweller/features/admin/data/datasources/jeweller_dashboard_datasource.dart';
import 'package:digital_jeweller/features/admin/data/repositories/jeweller_dashboard_repository_impl.dart';
import 'package:digital_jeweller/features/admin/domain/repositories/jeweller_dashboard_repository.dart';
import 'package:digital_jeweller/features/admin/domain/usecases/get_jeweller_dashboard_usecase.dart';

// Master Admin - Jeweller Feature
import 'package:digital_jeweller/features/master_admin/jeweller/data/services/jeweller_service.dart';
import 'package:digital_jeweller/features/master_admin/jeweller/data/repositories/jeweller_repository_impl.dart';
import 'package:digital_jeweller/features/master_admin/jeweller/domain/repositories/jeweller_repository.dart';
import 'package:digital_jeweller/features/master_admin/jeweller/domain/usecases/get_jewellers_usecase.dart';
import 'package:digital_jeweller/features/master_admin/jeweller/domain/usecases/create_jeweller_usecase.dart';
import 'package:digital_jeweller/features/master_admin/jeweller/domain/usecases/delete_jeweller_usecase.dart';
import 'package:digital_jeweller/features/master_admin/jeweller/domain/usecases/update_jeweller_usecase.dart';

// Master Admin - Jeweller Management Feature
import 'package:digital_jeweller/features/master_admin/jeweller_management/data/services/jeweller_service.dart' as jm;
import 'package:digital_jeweller/features/master_admin/jeweller_management/data/repositories/jeweller_repository_impl.dart' as jm;
import 'package:digital_jeweller/features/master_admin/jeweller_management/domain/repositories/jeweller_repository.dart' as jm;
import 'package:digital_jeweller/features/master_admin/jeweller_management/domain/usecases/get_jewellers_usecase.dart' as jm;
import 'package:digital_jeweller/features/master_admin/jeweller_management/domain/usecases/create_jeweller_usecase.dart' as jm;
import 'package:digital_jeweller/features/master_admin/jeweller_management/domain/usecases/delete_jeweller_usecase.dart' as jm;
import 'package:digital_jeweller/features/master_admin/jeweller_management/domain/usecases/toggle_jeweller_status_usecase.dart';

// Master Admin - Legacy (to be removed)
import 'package:digital_jeweller/features/master_admin/data/data_service/master_admin_service.dart';
import 'package:digital_jeweller/features/master_admin/data/repositories/master_admin_repository_impl.dart';
import 'package:digital_jeweller/features/master_admin/domain/repositories/master_admin_repository.dart';

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

  sl.registerLazySingleton<LoginService>(
    () =>
        LoginServiceImpl(dioClient: sl<DioClient>(), storage: sl<GetStorage>()),
  );

  // Auth Services
  sl.registerLazySingleton<auth_svc.AuthService>(
    () => auth_svc.AuthServiceImpl(dioClient: sl<DioClient>(), storage: sl<GetStorage>()),
  );

  sl.registerLazySingleton<auth_ds.AuthService>(
    () => auth_ds.AuthServiceImpl(),
  );

  sl.registerLazySingleton<BannerService>(
    () => BannerServiceImpl(dio: sl<Dio>(), storage: sl<GetStorage>()),
  );

  sl.registerLazySingleton<AdminCustomerRemoteDataSource>(
    () => AdminCustomerRemoteDataSource(),
  );

  sl.registerLazySingleton<SchemeRemoteDataSource>(
    () => SchemeRemoteDataSourceImpl(dio: sl<Dio>()),
  );

  // Jeweller Management Service
  sl.registerLazySingleton<JewellerService>(
    () => JewellerServiceImpl(dioClient: sl<DioClient>()),
  );

  // Jeweller Management Service (new)
  sl.registerLazySingleton<jm.JewellerService>(
    () => jm.JewellerServiceImpl(dioClient: sl<DioClient>()),
  );

  // Legacy Master Admin Data Source (to be removed)
  sl.registerLazySingleton<MasterAdminRemoteDataSource>(
    () => MasterAdminRemoteDataSourceImpl(),
  );

  // Jeweller Dashboard Data Source
  sl.registerLazySingleton<JewellerDashboardDataSource>(
    () => JewellerDashboardDataSourceImpl(dio: sl<Dio>()),
  );

  // Customer Dashboard Data Source
  sl.registerLazySingleton<CustomerDashboardDataSource>(
    () => CustomerDashboardDataSourceImpl(dio: sl<Dio>()),
  );

  // ============================================
  // REPOSITORIES
  // ============================================

  // Auth Repository
  sl.registerLazySingleton<LoginRepositoryImpl>(
    () => LoginRepositoryImpl(loginService: sl<LoginService>()),
  );
  sl.registerLazySingleton<LoginRepository>(() => sl<LoginRepositoryImpl>());

  // Auth Repository (new)
  sl.registerLazySingleton<AuthRepositoryImpl>(
    () => AuthRepositoryImpl(),
  );
  sl.registerLazySingleton<AuthRepository>(() => sl<AuthRepositoryImpl>());

  // Banner Repository
  sl.registerLazySingleton<BannerRepositoryImpl>(
    () => BannerRepositoryImpl(service: sl<BannerService>()),
  );
  sl.registerLazySingleton<BannerRepository>(() => sl<BannerRepositoryImpl>());

  // Admin Customer Repository
  sl.registerLazySingleton<AdminCustomerRepositoryImpl>(
    () => AdminCustomerRepositoryImpl(
      dataSource: sl<AdminCustomerRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<AdminCustomerRepository>(
    () => sl<AdminCustomerRepositoryImpl>(),
  );

  // Scheme Repository
  sl.registerLazySingleton<SchemeRepositoryImpl>(
    () => SchemeRepositoryImpl(remoteDataSource: sl<SchemeRemoteDataSource>()),
  );
  sl.registerLazySingleton<SchemeRepository>(() => sl<SchemeRepositoryImpl>());

  // Jeweller Repository
  sl.registerLazySingleton<JewellerRepositoryImpl>(
    () => JewellerRepositoryImpl(service: sl<JewellerService>()),
  );
  sl.registerLazySingleton<JewellerRepository>(
    () => sl<JewellerRepositoryImpl>(),
  );

  // Jeweller Management Repository (new)
  sl.registerLazySingleton<jm.JewellerRepositoryImpl>(
    () => jm.JewellerRepositoryImpl(service: sl<jm.JewellerService>()),
  );
  sl.registerLazySingleton<jm.JewellerRepository>(
    () => sl<jm.JewellerRepositoryImpl>(),
  );

  // Legacy Master Admin Repository (to be removed)
  sl.registerLazySingleton<MasterAdminRepositoryImpl>(
    () => MasterAdminRepositoryImpl(
      remoteDataSource: sl<MasterAdminRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<MasterAdminRepository>(
    () => sl<MasterAdminRepositoryImpl>(),
  );

  // Jeweller Dashboard Repository
  sl.registerLazySingleton<JewellerDashboardRepositoryImpl>(
    () => JewellerDashboardRepositoryImpl(
      dataSource: sl<JewellerDashboardDataSource>(),
    ),
  );
  sl.registerLazySingleton<JewellerDashboardRepository>(
    () => sl<JewellerDashboardRepositoryImpl>(),
  );

  // Customer Dashboard Repository
  sl.registerLazySingleton<CustomerDashboardRepositoryImpl>(
    () => CustomerDashboardRepositoryImpl(
      dataSource: sl<CustomerDashboardDataSource>(),
    ),
  );
  sl.registerLazySingleton<CustomerDashboardRepository>(
    () => sl<CustomerDashboardRepositoryImpl>(),
  );

  // USE CASES
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<LoginRepository>()),
  );
  sl.registerLazySingleton<CreateBannerUseCase>(
    () => CreateBannerUseCase(sl<BannerRepository>()),
  );
  sl.registerLazySingleton<GetBannersUseCase>(() => GetBannersUseCase());
  sl.registerLazySingleton<GetSchemesUseCase>(
    () => GetSchemesUseCase(sl<SchemeRepository>()),
  );
  sl.registerLazySingleton<CreateSchemeUseCase>(
    () => CreateSchemeUseCase(sl<SchemeRepository>()),
  );
  sl.registerLazySingleton<UpdateSchemeUseCase>(
    () => UpdateSchemeUseCase(sl<SchemeRepository>()),
  );
  sl.registerLazySingleton<DeleteSchemeUseCase>(
    () => DeleteSchemeUseCase(sl<SchemeRepository>()),
  );
  sl.registerLazySingleton<JoinSchemeUseCase>(
    () => JoinSchemeUseCase(repository: sl<SchemeRepository>()),
  );
  sl.registerLazySingleton<JoinedSchemeUseCase>(
    () => JoinedSchemeUseCase(repository: sl<SchemeRepository>()),
  );
  sl.registerLazySingleton<AdminSchemesAddUpdateUsecase>(
    () => AdminSchemesAddUpdateUsecase(sl<SchemeRepository>()),
  );

  // Jeweller Dashboard Use Case
  sl.registerLazySingleton<GetJewellerDashboardUseCase>(
    () => GetJewellerDashboardUseCase(
      repository: sl<JewellerDashboardRepository>(),
    ),
  );

  // Customer Dashboard Use Case
  sl.registerLazySingleton<GetCustomerDashboardUseCase>(
    () => GetCustomerDashboardUseCase(
      repository: sl<CustomerDashboardRepository>(),
    ),
  );

  // Jeweller Management Use Cases
  sl.registerLazySingleton<GetJewellersUseCase>(
    () => GetJewellersUseCase(repository: sl<JewellerRepository>()),
  );
  sl.registerLazySingleton<CreateJewellerUseCase>(
    () => CreateJewellerUseCase(repository: sl<JewellerRepository>()),
  );
  sl.registerLazySingleton<DeleteJewellerUseCase>(
    () => DeleteJewellerUseCase(repository: sl<JewellerRepository>()),
  );
  sl.registerLazySingleton<UpdateJewellerStatusUseCase>(
    () => UpdateJewellerStatusUseCase(repository: sl<JewellerRepository>()),
  );

  // Jeweller Management Use Cases (new)
  sl.registerLazySingleton<jm.GetJewellersUseCase>(
    () => jm.GetJewellersUseCase(repository: sl<jm.JewellerRepository>()),
  );
  sl.registerLazySingleton<jm.CreateJewellerUseCase>(
    () => jm.CreateJewellerUseCase(repository: sl<jm.JewellerRepository>()),
  );
  sl.registerLazySingleton<jm.DeleteJewellerUseCase>(
    () => jm.DeleteJewellerUseCase(repository: sl<jm.JewellerRepository>()),
  );
  sl.registerLazySingleton<ToggleJewellerStatusUseCase>(
    () => ToggleJewellerStatusUseCase(repository: sl<jm.JewellerRepository>()),
  );

  // Legacy Master Admin Use Case (to be removed)
  sl.registerLazySingleton<MasterAdminJewellerUsecase>(
    () => MasterAdminJewellerUsecase(),
  );
  sl.registerLazySingleton<AuthController>(() => AuthController());
}

/// Get a dependency from service locator
T getIt<T extends Object>() => sl<T>();
