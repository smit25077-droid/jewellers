# 🏆 Digital Jeweller - Clean Architecture with GetX

A comprehensive Flutter application built with **Clean Architecture** and **GetX** state management, featuring role-based authentication, beautiful UI with light/dark theme support, and a complete navigation system.

## ✨ Features

### 🏗️ Architecture
- ✅ **Clean Architecture** - Proper separation of concerns (Presentation, Domain, Data)
- ✅ **Base Classes** - Reusable BaseController, BaseService, BaseRepository
- ✅ **SOLID Principles** - Maintainable and scalable code structure
- ✅ **Dependency Injection** - Centralized dependency management

### 🎨 UI/UX
- ✅ **Premium Gold Theme** - Beautiful jewelry-themed color palette
- ✅ **Light/Dark Mode** - Automatic theme switching
- ✅ **Smooth Animations** - Page transitions and micro-interactions
- ✅ **Responsive Design** - Works on all screen sizes
- ✅ **Common Widgets** - Reusable UI components

### 🔐 Authentication
- ✅ **Login System** - Secure authentication
- ✅ **Registration** - New user signup
- ✅ **Forgot Password** - Password recovery
- ✅ **Role-Based Access** - Master Admin, Admin, User roles
- ✅ **Token Management** - Automatic token injection

### 🧭 Navigation
- ✅ **GetX Routing** - Declarative navigation
- ✅ **Route Constants** - Type-safe navigation
- ✅ **Deep Linking** - Support for deep links
- ✅ **Smooth Transitions** - Beautiful page transitions

### 🛠️ Developer Experience
- ✅ **Error Handling** - Comprehensive exception handling
- ✅ **Loading States** - Automatic loading indicators
- ✅ **API Logging** - Request/Response logging
- ✅ **Code Documentation** - Well-documented codebase

## 📁 Project Structure

```
lib/
├── core/                           # Core functionality
│   ├── base/                       # Base classes
│   │   ├── base_controller.dart    # Base GetX controller
│   │   ├── base_service.dart       # Base API service
│   │   └── base_repository.dart    # Base repository
│   ├── constants/                  # App constants
│   │   ├── api_endpoints.dart      # API endpoints
│   │   └── app_routes.dart         # Route names
│   ├── error/                      # Error handling
│   │   ├── exceptions.dart         # Exception classes
│   │   └── failures.dart           # Failure classes
│   ├── network/                    # Network layer
│   │   ├── dio_client.dart         # HTTP client
│   │   └── logger_interceptor.dart # API logger
│   ├── routes/                     # Routing
│   │   └── app_pages.dart          # Route configuration
│   ├── theme/                      # Theming
│   │   ├── app_colors.dart         # Color palette
│   │   └── app_theme.dart          # Theme config
│   └── widgets/                    # Common widgets
│       ├── common_loading.dart     # Loading widgets
│       ├── common_states.dart      # State widgets
│       └── common_cards.dart       # Card widgets
│
├── features/                       # Feature modules
│   ├── auth/                       # Authentication
│   │   ├── data/                   # Data layer
│   │   ├── domain/                 # Domain layer
│   │   └── presentation/           # UI layer
│   ├── master_admin/               # Master Admin feature
│   ├── admin/                      # Admin feature
│   └── user/                       # User feature
│
└── main.dart                       # App entry point
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.x or higher)
- Dart SDK (3.x or higher)
- Android Studio / VS Code
- Android Emulator or Physical Device

### Installation

1. **Clone the repository**
   ```bash
   cd d:/FlutterProject/digital_jeweller
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 🎯 User Flows

### Master Admin (super_admin)
- View dashboard with statistics
- Manage jewellers (add, edit, delete)
- Manage subscription plans
- View and edit profile

### Admin (jewellers_admin)
- View business dashboard
- Manage customers/users
- Create and manage schemes
- Manage advertising banners
- Handle payment requests

### User (customer)
- View personal dashboard
- Browse schemes
- Make payments
- View payment history
- Manage profile

## 🎨 Theme System

### Color Palette
```dart
Primary Gold:    #CFB53B
Dark Gold:       #AA8A2C
Light Gold:      #E6D27E
Jewel Gold:      #D4AF37
```

### Usage
```dart
// Use theme colors
Container(
  color: AppColors.primary,
  child: Text(
    'Hello',
    style: Theme.of(context).textTheme.headlineMedium,
  ),
)
```

## 🧭 Navigation

### Route Navigation
```dart
// Navigate to a route
Get.toNamed(AppRoutes.userProfile);

// Navigate and clear stack
Get.offAllNamed(AppRoutes.login);

// Navigate with arguments
Get.toNamed(
  AppRoutes.userProfile,
  arguments: {'userId': 123},
);

// Go back
Get.back();
```

### Available Routes
- `/login` - Login Screen
- `/register` - Registration Screen
- `/forgot-password` - Password Recovery
- `/master-admin/dashboard` - Master Admin Dashboard
- `/admin/dashboard` - Admin Dashboard
- `/user/dashboard` - User Dashboard
- And many more...

## 🔧 Common Widgets

### Loading Widgets
```dart
// Full screen loading
CommonLoading(message: 'Loading data...')

// Small loading indicator
SmallLoading(color: AppColors.primary)

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
  title: 'No items found',
  message: 'Try adding some items',
  actionText: 'Add Item',
  onAction: () => controller.addItem(),
)

// Error state
ErrorState(
  title: 'Something went wrong',
  message: 'Please try again later',
  onRetry: () => controller.retry(),
)

// Network error
NetworkError(
  onRetry: () => controller.fetchData(),
)
```

### Card Widgets
```dart
// Common card
CommonCard(
  child: Text('Card content'),
  onTap: () => print('Tapped'),
)

// Stat card for dashboards
StatCard(
  title: 'Total Users',
  value: '1,234',
  icon: Icons.people,
  color: AppColors.primary,
)

// Info row
InfoRow(
  label: 'Email',
  value: 'user@example.com',
  icon: Icons.email,
)
```

## 🏗️ Architecture Patterns

### Controller Pattern
```dart
class MyController extends BaseController {
  final MyRepository repository;
  
  MyController({required this.repository});
  
  final data = <Item>[].obs;
  
  Future<void> loadData() async {
    try {
      showLoading();
      final result = await repository.getData();
      data.value = result;
      showSuccess('Data loaded successfully');
    } catch (e) {
      showError('Failed to load data: $e');
    } finally {
      hideLoading();
    }
  }
}
```

### Service Pattern
```dart
class MyService extends BaseService {
  MyService({required super.dioClient});
  
  Future<Response> fetchItems() async {
    return await get(
      '/items',
      showLoading: true,
      loadingMessage: 'Loading items...',
    );
  }
  
  Future<Response> createItem(Map<String, dynamic> data) async {
    return await post(
      '/items',
      data: data,
      showLoading: true,
    );
  }
}
```

### Repository Pattern
```dart
class MyRepositoryImpl extends BaseRepository implements MyRepository {
  final MyService service;
  
  MyRepositoryImpl({required this.service});
  
  @override
  Future<List<Item>> getItems() async {
    return await execute(() async {
      final response = await service.fetchItems();
      return (response.data as List)
          .map((e) => Item.fromJson(e))
          .toList();
    });
  }
}
```

## 🐛 Error Handling

### Exception Types
- `ServerException` - API/Server errors
- `NetworkException` - Network connectivity errors
- `CacheException` - Local storage errors
- `ValidationException` - Input validation errors
- `AuthenticationException` - Authentication errors
- `AuthorizationException` - Permission errors

### Usage
```dart
try {
  await repository.getData();
} on ServerException catch (e) {
  print('Server error: ${e.message}');
} on NetworkException catch (e) {
  print('Network error: ${e.message}');
} catch (e) {
  print('Unknown error: $e');
}
```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.6              # State management & routing
  get_storage: ^2.1.1      # Local storage
  dio: ^5.7.0              # HTTP client
  google_fonts: ^6.3.3     # Custom fonts
```

## 📚 Documentation

- **[ARCHITECTURE.md](ARCHITECTURE.md)** - Detailed architecture documentation
- **[IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md)** - Feature implementation summary
- **[QUICK_START.md](QUICK_START.md)** - Quick start guide

## 🧪 Testing

### Run Tests
```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test/

# Widget tests
flutter test test/widget_test.dart
```

### Test Coverage
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## 🚀 Building for Production

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## 🎯 Best Practices

1. **Always use base classes** for consistency
2. **Use route constants** instead of hardcoded strings
3. **Handle errors properly** with try-catch blocks
4. **Show loading states** for better UX
5. **Use common widgets** for UI consistency
6. **Follow clean architecture** principles
7. **Write meaningful commit messages**
8. **Document complex logic**

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👥 Authors

- **Development Team** - *Initial work*

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- GetX team for the state management solution
- All contributors and supporters

## 📞 Support

For support, email support@digitaljeweller.com or join our Slack channel.

---

**Built with ❤️ using Flutter & GetX**

## 🎉 Status

✅ **Application is running successfully!**

The app has been tested and verified to work correctly with:
- All navigation flows working
- Theme system functioning properly
- Error handling in place
- Loading states working
- All user flows accessible

**Ready for development and deployment!** 🚀
#   j e w e l l e r s  
 