# Digital Jeweller - Clean Architecture with GetX

## 📁 Project Structure

```
lib/
├── core/
│   ├── base/
│   │   ├── base_controller.dart      # Base controller for all GetX controllers
│   │   ├── base_service.dart         # Base service for all API services
│   │   └── base_repository.dart      # Base repository for all repositories
│   ├── constants/
│   │   ├── api_endpoints.dart        # API endpoint constants
│   │   └── app_routes.dart           # Route name constants
│   ├── error/
│   │   ├── exceptions.dart           # Exception classes
│   │   └── failures.dart             # Failure classes
│   ├── network/
│   │   ├── dio_client.dart           # Dio HTTP client configuration
│   │   ├── logger_interceptor.dart   # API logging interceptor
│   │   └── api_service.dart          # Common API service
│   ├── routes/
│   │   └── app_pages.dart            # GetX route configuration
│   ├── theme/
│   │   ├── app_colors.dart           # Color constants (Light/Dark)
│   │   └── app_theme.dart            # Theme configuration
│   ├── utils/
│   │   ├── loading_overlay.dart      # Loading overlay utility
│   │   └── route_helper.dart         # Route helper functions
│   └── widgets/
│       ├── common_loading.dart       # Common loading widgets
│       ├── common_states.dart        # Empty/Error state widgets
│       └── common_cards.dart         # Common card widgets
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── auth_remote_data_source.dart
│   │   │   ├── models/
│   │   │   │   └── login_response_model.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart
│   │   │   └── usecases/
│   │   │       └── login_usecase.dart
│   │   └── presentation/
│   │       ├── controllers/
│   │       │   └── auth_controller.dart
│   │       └── pages/
│   │           ├── login_screen.dart
│   │           ├── register_screen.dart
│   │           └── forgot_password_screen.dart
│   │
│   ├── master_admin/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │       ├── controllers/
│   │       │   └── master_admin_controller.dart
│   │       └── pages/
│   │           └── master_admin_dashboard.dart
│   │
│   ├── admin/
│   │   └── presentation/
│   │       ├── controllers/
│   │       │   └── admin_controller.dart
│   │       └── pages/
│   │           └── admin_dashboard.dart
│   │
│   └── user/
│       └── presentation/
│           └── pages/
│               ├── user_dashboard.dart
│               └── user_profile_page.dart
│
└── main.dart
```

## 🏗️ Architecture Overview

### Clean Architecture Layers

1. **Presentation Layer** (UI)
   - Pages/Screens
   - Controllers (GetX)
   - Widgets

2. **Domain Layer** (Business Logic)
   - Entities
   - Use Cases
   - Repository Interfaces

3. **Data Layer** (Data Sources)
   - Repository Implementations
   - Data Sources (Remote/Local)
   - Models

### Base Classes

#### BaseController
All controllers extend `BaseController` which provides:
- `showLoading()` / `hideLoading()` - Loading state management
- `showError(message)` - Error snackbar
- `showSuccess(message)` - Success snackbar
- `isLoading` - Observable loading state

```dart
class MyController extends BaseController {
  Future<void> fetchData() async {
    try {
      showLoading();
      final data = await repository.getData();
      showSuccess('Data loaded successfully');
    } catch (e) {
      showError('Failed to load data');
    } finally {
      hideLoading();
    }
  }
}
```

#### BaseService
All API services extend `BaseService` which provides:
- `get()` - GET request with error handling
- `post()` - POST request with error handling
- `put()` - PUT request with error handling
- `delete()` - DELETE request with error handling
- `patch()` - PATCH request with error handling

```dart
class MyService extends BaseService {
  MyService({required super.dioClient});

  Future<Response> fetchUsers() async {
    return await get(
      '/users',
      showLoading: true,
      loadingMessage: 'Loading users...',
    );
  }
}
```

#### BaseRepository
All repositories extend `BaseRepository` which provides:
- `execute()` - Execute function with error handling
- `executeSimple()` - Execute without error conversion

```dart
class MyRepositoryImpl extends BaseRepository implements MyRepository {
  @override
  Future<List<User>> getUsers() async {
    return await execute(() async {
      final response = await dataSource.fetchUsers();
      return response.map((e) => User.fromJson(e)).toList();
    });
  }
}
```

## 🎨 Theme System

### Colors
The app uses a premium gold color palette defined in `app_colors.dart`:
- **Primary**: Gold (#CFB53B)
- **Primary Dark**: Dark Gold (#AA8A2C)
- **Primary Light**: Light Gold (#E6D27E)

### Light/Dark Theme Support
The app automatically supports both light and dark themes:
```dart
// In main.dart
theme: AppTheme.light,
darkTheme: AppTheme.dark,
themeMode: ThemeMode.system,
```

## 🧭 Navigation System

### Route Constants
All routes are defined in `app_routes.dart`:
```dart
AppRoutes.login
AppRoutes.register
AppRoutes.masterAdminDashboard
AppRoutes.adminDashboard
AppRoutes.userDashboard
// ... and more
```

### Navigation Usage
```dart
// Navigate to a route
Get.toNamed(AppRoutes.userProfile);

// Navigate and remove all previous routes
Get.offAllNamed(AppRoutes.login);

// Navigate with arguments
Get.toNamed(AppRoutes.userProfile, arguments: {'userId': 123});

// Go back
Get.back();
```

## 🔧 Common Widgets

### Loading Widgets
```dart
// Full screen loading
CommonLoading(message: 'Loading...')

// Small loading indicator
SmallLoading()

// Loading button
LoadingButton(
  isLoading: controller.isLoading.value,
  onPressed: () => controller.submit(),
  text: 'Submit',
)
```

### State Widgets
```dart
// Empty state
EmptyState(
  icon: Icons.inbox,
  title: 'No data found',
  message: 'Try adding some items',
  actionText: 'Add Item',
  onAction: () => controller.addItem(),
)

// Error state
ErrorState(
  title: 'Something went wrong',
  message: 'Please try again',
  onRetry: () => controller.retry(),
)

// Network error
NetworkError(
  onRetry: () => controller.retry(),
)
```

### Card Widgets
```dart
// Common card
CommonCard(
  child: Text('Content'),
  onTap: () {},
)

// Stat card (for dashboards)
StatCard(
  title: 'Total Users',
  value: '1,234',
  icon: Icons.people,
  color: AppColors.primary,
  onTap: () {},
)

// Info row
InfoRow(
  label: 'Email',
  value: 'user@example.com',
  icon: Icons.email,
)
```

## 🔐 Authentication Flow

### Login
1. User enters credentials
2. `AuthController.login()` is called
3. `LoginUseCase` executes
4. `AuthRepository` fetches data from `AuthRemoteDataSource`
5. Token is saved to local storage
6. User is navigated based on role:
   - `super_admin` → Master Admin Dashboard
   - `jewellers_admin` → Admin Dashboard
   - `customer` → User Dashboard

### Logout
```dart
authController.logout()
```

## 🚀 User Flows

### Master Admin Flow
- Dashboard with statistics
- Manage jewellers (add, edit, delete)
- Manage subscription plans
- View profile

### Admin Flow
- Dashboard with business metrics
- Manage users (customers)
- Manage schemes
- Manage advertising banners
- Handle payment requests

### User Flow
- Dashboard with personal schemes
- View profile
- Make payments
- View payment history
- Notifications

## 📝 Error Handling

### Exception Types
- `ServerException` - API errors
- `NetworkException` - Connectivity errors
- `CacheException` - Local storage errors
- `ValidationException` - Input validation errors
- `AuthenticationException` - Auth errors
- `AuthorizationException` - Permission errors

### Failure Types
- `ServerFailure`
- `NetworkFailure`
- `CacheFailure`
- `ValidationFailure`
- `AuthenticationFailure`
- `AuthorizationFailure`

## 🧪 Testing

To test the application:

```bash
# Run the app
flutter run

# Build for production
flutter build apk --release
flutter build ios --release
```

## 📦 Dependencies

Key dependencies used:
- `get` - State management and routing
- `get_storage` - Local storage
- `dio` - HTTP client
- `google_fonts` - Custom fonts

## 🎯 Best Practices

1. **Always use base classes** for controllers, services, and repositories
2. **Use route constants** instead of hardcoded strings
3. **Use common widgets** for consistent UI
4. **Handle errors properly** using try-catch and show user-friendly messages
5. **Use loading states** to provide feedback to users
6. **Follow clean architecture** - keep layers separated
7. **Use dependency injection** in main.dart
8. **Use GetX reactive programming** with `.obs` and `Obx()`

## 🔄 Adding New Features

### Step 1: Create Feature Structure
```
features/
└── my_feature/
    ├── data/
    │   ├── datasources/
    │   ├── models/
    │   └── repositories/
    ├── domain/
    │   ├── entities/
    │   ├── repositories/
    │   └── usecases/
    └── presentation/
        ├── controllers/
        ├── pages/
        └── widgets/
```

### Step 2: Create Data Source
```dart
class MyFeatureRemoteDataSource extends BaseService {
  MyFeatureRemoteDataSource({required super.dioClient});
  
  Future<Response> fetchData() async {
    return await get('/my-endpoint');
  }
}
```

### Step 3: Create Repository
```dart
class MyFeatureRepositoryImpl extends BaseRepository 
    implements MyFeatureRepository {
  final MyFeatureRemoteDataSource dataSource;
  
  MyFeatureRepositoryImpl({required this.dataSource});
  
  @override
  Future<List<MyEntity>> getData() async {
    return await execute(() async {
      final response = await dataSource.fetchData();
      return (response.data as List)
          .map((e) => MyEntity.fromJson(e))
          .toList();
    });
  }
}
```

### Step 4: Create Controller
```dart
class MyFeatureController extends BaseController {
  final MyFeatureRepository repository;
  
  MyFeatureController({required this.repository});
  
  final data = <MyEntity>[].obs;
  
  Future<void> loadData() async {
    try {
      showLoading();
      final result = await repository.getData();
      data.value = result;
      showSuccess('Data loaded');
    } catch (e) {
      showError('Failed to load data');
    } finally {
      hideLoading();
    }
  }
}
```

### Step 5: Add Route
```dart
// In app_routes.dart
static const String myFeature = '/my-feature';

// In app_pages.dart
GetPage(
  name: AppRoutes.myFeature,
  page: () => const MyFeaturePage(),
  transition: Transition.fadeIn,
),
```

### Step 6: Register Dependencies
```dart
// In main.dart
final myFeatureDataSource = MyFeatureRemoteDataSource(
  dioClient: DioClient.instance,
);
final myFeatureRepository = MyFeatureRepositoryImpl(
  dataSource: myFeatureDataSource,
);
Get.put(MyFeatureController(repository: myFeatureRepository));
```

## 📞 Support

For issues or questions, refer to the codebase or contact the development team.
