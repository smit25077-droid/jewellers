# Core Module Documentation

This directory contains common utilities, configurations, and services used throughout the Digital Jeweller application.

## 📁 Structure

```
core/
├── constants/
│   ├── api_endpoints.dart    # All API endpoints and base URL
│   └── app_routes.dart        # All application routes
├── network/
│   ├── dio_client.dart        # Dio HTTP client with interceptors
│   └── api_service.dart       # Base API service class
├── routes/
│   └── app_pages.dart         # GetX pages configuration
├── theme/
│   ├── app_colors.dart        # Application colors
│   └── app_theme.dart         # Application theme
└── utils/
    ├── loading_overlay.dart   # Global loading overlay
    ├── route_helper.dart      # Navigation helper
    └── example_usage.dart     # Usage examples
```

## 🚀 Quick Start

### 1. Configure Base URL

Edit `lib/core/constants/api_endpoints.dart`:

```dart
static const String baseUrl = 'https://your-api-domain.com/api/v1';
```

### 2. Add Your Routes

Edit `lib/core/routes/app_pages.dart`:

```dart
GetPage(
  name: AppRoutes.yourRoute,
  page: () => YourPage(),
  transition: Transition.fadeIn,
),
```

### 3. Use in Your Code

#### API Calls with Loading

```dart
import 'package:digital_jeweller/core/network/api_service.dart';
import 'package:digital_jeweller/core/constants/api_endpoints.dart';

class MyDataService extends ApiService {
  Future<Response> fetchData() async {
    return await get(
      ApiEndpoints.products,
      showLoading: true,
      loadingMessage: 'Loading...',
    );
  }
}
```

#### Navigation

```dart
import 'package:digital_jeweller/core/utils/route_helper.dart';
import 'package:digital_jeweller/core/constants/app_routes.dart';

// Navigate to a route
RouteHelper.toNamed(AppRoutes.login);

// Navigate with arguments
RouteHelper.toNamed(
  AppRoutes.productDetails,
  arguments: {'id': '123'},
);

// Go back
RouteHelper.back();
```

#### Manual Loading Control

```dart
import 'package:digital_jeweller/core/utils/loading_overlay.dart';

// Show loading
LoadingOverlay.show(message: 'Please wait...');

// Hide loading
LoadingOverlay.hide();
```

## 📝 Features

### ✅ API Endpoints
- Centralized endpoint management
- Base URL configuration
- Helper methods for dynamic URLs
- Organized by feature (Auth, User, Admin, Products, etc.)

### ✅ API Service
- Dio HTTP client with interceptors
- Automatic token injection
- Error handling
- Loading overlay integration
- Support for GET, POST, PUT, DELETE, PATCH

### ✅ Loading Overlay
- Global loading indicator
- Customizable messages
- Prevents user interaction during loading
- Two implementations: Overlay and Dialog

### ✅ Route Management
- Centralized route definitions
- Type-safe navigation
- Navigation helpers
- Support for arguments and parameters

### ✅ Network Features
- Request/Response interceptors
- Automatic authentication token handling
- Connection timeout handling
- Error handling with user-friendly messages

## 🔧 Configuration

### Dio Client Configuration

The Dio client is configured in `lib/core/network/dio_client.dart`:

- **Base URL**: Set in `ApiEndpoints.baseUrl`
- **Timeouts**: 30 seconds for connect and receive
- **Headers**: JSON content type and accept
- **Interceptors**: Token injection and error handling

### Route Configuration

Routes are defined in two places:

1. **Route Names**: `lib/core/constants/app_routes.dart`
2. **Route Pages**: `lib/core/routes/app_pages.dart`

## 📚 Examples

See `lib/core/utils/example_usage.dart` for comprehensive examples of:
- API endpoint usage
- API service usage in data layer
- Loading overlay usage
- Route navigation usage
- Complete controller examples
- UI widget examples

## 🎯 Best Practices

1. **Always use route constants** instead of hardcoded strings
2. **Use showLoading parameter** in API calls for automatic loading
3. **Extend ApiService** for feature-specific data services
4. **Use RouteHelper** for all navigation
5. **Keep endpoints organized** by feature in api_endpoints.dart
6. **Handle errors gracefully** in your controllers

## 🔐 Authentication

The Dio client automatically adds the authentication token to all requests:

```dart
// Token is stored in GetStorage with key 'auth_token'
final token = _storage.read('auth_token');
if (token != null) {
  options.headers['Authorization'] = 'Bearer $token';
}
```

To set the token after login:

```dart
final storage = GetStorage();
storage.write('auth_token', 'your_token_here');
```

## 🐛 Error Handling

Errors are automatically handled by the Dio interceptor:

- Connection timeout
- Send/Receive timeout
- Bad response (400, 401, 403, 404, 500, etc.)
- Connection errors
- Request cancellation

You can customize error messages in `dio_client.dart`.

## 📱 Platform Support

This setup works on all Flutter platforms:
- Android
- iOS
- Web
- Windows
- macOS
- Linux

## 🤝 Contributing

When adding new features:

1. Add endpoints to `api_endpoints.dart`
2. Add routes to `app_routes.dart`
3. Add pages to `app_pages.dart`
4. Create feature-specific API services extending `ApiService`
5. Use `RouteHelper` for navigation
6. Use `LoadingOverlay` for loading states

## 📄 License

This is part of the Digital Jeweller project.
