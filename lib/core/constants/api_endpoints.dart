/// API Endpoints Configuration
class ApiEndpoints {
  // Base URL - Change this to your actual API base URL
  static const String baseUrl = 'http://192.168.1.95:5000/api';

  // Timeout durations
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Auth Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh-token';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String verifyOtp = '/auth/verify-otp';

  // User Endpoints
  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/profile/update';
  static const String changePassword = '/user/change-password';
  static const String getUserById = '/user'; // Add /{id}

  // Master Admin Endpoints
  static const String dashboard = '/master-admin/dashboard';
  static const String getAllUsers = '/master-admin/users';
  static const String createUser = '/master-admin/users/create';
  static const String updateUser = '/master-admin/users/update'; // Add /{id}
  static const String deleteUser = '/master-admin/users/delete'; // Add /{id}
  static const String getAdmins = '/master-admin/admins';

  // Admin Endpoints
  static const String adminDashboard = '/admin/dashboard';
  static const String getProducts = '/admin/products';
  static const String createProduct = '/admin/products/create';
  static const String updateProduct = '/admin/products/update'; // Add /{id}
  static const String deleteProduct = '/admin/products/delete'; // Add /{id}
  static const String getSchemeList = '/schemes'; // Add /{id}
  static const String joinScheme = '/schemes'; // Add /{id}/join
  static const String getJoinedSchemes = '/schemes/me/joined';

  // Customer Endpoints (Admin - Jeweller side)
  static const String customers = '/customers';

  // Product/Jewellery Endpoints
  static const String products = '/products';
  static const String productDetails = '/products'; // Add /{id}
  static const String categories = '/categories';
  static const String searchProducts = '/products/search';
  static const String filterProducts = '/products/filter';

  // Order Endpoints
  static const String orders = '/orders';
  static const String createOrder = '/orders/create';
  static const String orderDetails = '/orders'; // Add /{id}
  static const String updateOrderStatus = '/orders/update-status'; // Add /{id}
  static const String cancelOrder = '/orders/cancel'; // Add /{id}

  // Cart Endpoints
  static const String cart = '/cart';
  static const String addToCart = '/cart/add';
  static const String updateCart = '/cart/update';
  static const String removeFromCart = '/cart/remove'; // Add /{id}
  static const String clearCart = '/cart/clear';

  // Wishlist Endpoints
  static const String wishlist = '/wishlist';
  static const String addToWishlist = '/wishlist/add';
  static const String removeFromWishlist = '/wishlist/remove'; // Add /{id}

  // Notification Endpoints
  static const String notifications = '/notifications';
  static const String markAsRead = '/notifications/mark-read'; // Add /{id}
  static const String markAllAsRead = '/notifications/mark-all-read';

  // Helper method to build URL with path parameters
  static String withId(String endpoint, dynamic id) {
    return '$endpoint/$id';
  }

  // Helper method to build URL with query parameters
  static String withQuery(String endpoint, Map<String, dynamic> params) {
    if (params.isEmpty) return endpoint;

    final query = params.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');

    return '$endpoint?$query';
  }
}
