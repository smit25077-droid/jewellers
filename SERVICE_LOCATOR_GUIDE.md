# Service Locator Setup Guide

## Overview
This project uses **GetIt** for dependency injection and **GetX** for state management. All dependencies are registered in `lib/core/service_locator.dart`.

## Setup in main.dart

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize GetStorage
  await GetStorage.init();
  
  // Initialize Service Locator (IMPORTANT!)
  await setupLocator();
  
  runApp(MyApp());
}
```

## How to Use Dependencies

### 1. In Controllers (GetX)

Controllers are automatically registered with GetX. Just use `Get.find<>()`:

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get controller instance
    final controller = Get.find<AuthController>();
    
    return Scaffold(
      body: Obx(() => Text(controller.someValue.value)),
    );
  }
}
```

### 2. In Repositories or Services

Use the service locator directly:

```dart
import 'package:digital_jeweller/core/service_locator.dart';

class MyService {
  final repository = sl<AuthRepository>();
  
  Future<void> doSomething() async {
    await repository.someMethod();
  }
}
```

Or use the helper function:

```dart
final repo = getIt<AuthRepository>();
```

### 3. In Routes (GetX)

Controllers are lazy-loaded, so they're created when first accessed:

```dart
GetPage(
  name: '/login',
  page: () => LoginPage(),
  binding: BindingsBuilder(() {
    // Controller is already registered, just ensure it's available
    Get.find<AuthController>();
  }),
)
```

## Registered Dependencies

### Core
- `DioClient` - HTTP client singleton
- `Dio` - Dio instance

### Data Sources
- `AuthRemoteDataSource`
- `AdminCustomerRemoteDataSource`
- `SchemeRemoteDataSource`
- `MasterAdminRemoteDataSource`

### Repositories
- `AuthRepository`
- `AdminCustomerRepository`
- `SchemeRepository`
- `MasterAdminRepository`

### Use Cases
- `LoginUseCase`
- `GetSchemesUseCase`
- `CreateSchemeUseCase`
- `UpdateSchemeUseCase`
- `DeleteSchemeUseCase`

### Controllers (GetX)
- `AuthController`
- `MasterAdminController`
- `AdminController`
- `AdminDashboardController`
- `AdminCustomerListController`
- `CustomerAddUpdateController`
- `SchemeController`
- `AdminSchemeAddUpdateController`

## Adding New Dependencies

### 1. Add a New Repository

```dart
// In setupLocator()

// Data Source
sl.registerLazySingleton<MyDataSource>(
  () => MyDataSourceImpl(dioClient: sl<DioClient>()),
);

// Repository
sl.registerLazySingleton<MyRepository>(
  () => MyRepositoryImpl(dataSource: sl<MyDataSource>()),
);
```

### 2. Add a New Use Case

```dart
// In setupLocator()
sl.registerLazySingleton(() => MyUseCase(sl<MyRepository>()));
```

### 3. Add a New Controller

```dart
// In _registerControllers()
Get.lazyPut<MyController>(
  () => MyController(useCase: sl<MyUseCase>()),
  fenix: true, // Recreates controller if disposed
);
```

## Benefits

✅ **No Manual Instantiation** - All dependencies are created automatically
✅ **Singleton Pattern** - Shared instances across the app
✅ **Lazy Loading** - Dependencies created only when needed
✅ **Easy Testing** - Can mock dependencies easily
✅ **Clean Code** - No need to pass dependencies through constructors manually
✅ **Type Safety** - Compile-time type checking

## Example: Before vs After

### Before (Manual)
```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final dataSource = MyDataSource(dio: dio);
    final repository = MyRepository(dataSource: dataSource);
    final useCase = MyUseCase(repository: repository);
    final controller = MyController(useCase: useCase);
    
    // Use controller...
  }
}
```

### After (Service Locator)
```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MyController>();
    
    // Use controller...
  }
}
```

## Troubleshooting

### Error: "Object/factory with type X is not registered"
- Make sure you called `await setupLocator()` in main.dart
- Check that the dependency is registered in service_locator.dart

### Error: "Controller not found"
- Controllers are lazy-loaded. Make sure the route is accessed at least once
- Or manually initialize: `Get.put(Get.find<MyController>())`

### Testing
```dart
// Reset all dependencies before each test
setUp(() async {
  await resetLocator();
  await setupLocator();
});
```

## Notes

- `fenix: true` in GetX controllers means they will be recreated if disposed
- Use `registerLazySingleton` for services that should be created once
- Use `registerFactory` if you need a new instance every time
- Controllers use GetX's lazy loading, not GetIt
