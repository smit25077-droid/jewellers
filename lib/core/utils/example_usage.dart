/// EXAMPLE USAGE GUIDE
/// 
/// This file demonstrates how to use the common features in your project

// ============================================
// 1. API ENDPOINTS USAGE
// ============================================

/*
import '../constants/api_endpoints.dart';

// Simple endpoint
String loginUrl = ApiEndpoints.login;

// Endpoint with ID
String userUrl = ApiEndpoints.withId(ApiEndpoints.getUserById, '123');
// Result: /user/123

// Endpoint with query parameters
String productsUrl = ApiEndpoints.withQuery(
  ApiEndpoints.products,
  {'category': 'rings', 'page': '1', 'limit': '10'}
);
// Result: /products?category=rings&page=1&limit=10
*/

// ============================================
// 2. API SERVICE USAGE IN DATA LAYER
// ============================================

/*
import '../network/api_service.dart';
import '../constants/api_endpoints.dart';

class MyDataService extends ApiService {
  // GET request with loading
  Future<Response> fetchData() async {
    return await get(
      ApiEndpoints.products,
    );
  }

  // POST request with loading
  Future<Response> createData(Map<String, dynamic> data) async {
    return await post(
      ApiEndpoints.createProduct,
      data: data,
    );
  }

  // GET with query parameters
  Future<Response> searchProducts(String query) async {
    return await get(
      ApiEndpoints.searchProducts,
      queryParameters: {'q': query},
    );
  }
}
*/

// ============================================
// 3. LOADING OVERLAY USAGE
// ============================================

/*
import '../utils/loading_overlay.dart';

// Show loading
LoadingOverlay.show(message: 'Please wait...');

// Hide loading
LoadingOverlay.hide();

// Show loading without message
LoadingOverlay.show();

// Alternative: Using LoadingDialog
LoadingDialog.show(message: 'Processing...');
LoadingDialog.hide();
*/

// ============================================
// 4. ROUTE NAVIGATION USAGE
// ============================================

/*
import '../utils/route_helper.dart';
import '../constants/app_routes.dart';

// Navigate to a route
RouteHelper.toNamed(AppRoutes.login);

// Navigate with arguments
RouteHelper.toNamed(
  AppRoutes.productDetails,
  arguments: {'productId': '123'},
);

// Navigate with parameters
RouteHelper.toNamed(
  AppRoutes.productDetails,
  parameters: {'id': '123'},
);

// Navigate and remove all previous routes (like after login)
RouteHelper.offAllNamed(AppRoutes.userHome);

// Navigate and remove previous route
RouteHelper.offNamed(AppRoutes.login);

// Go back
RouteHelper.back();

// Go back with result
RouteHelper.back(result: {'success': true});

// Check if can go back
if (RouteHelper.canGoBack()) {
  RouteHelper.back();
}
*/

// ============================================
// 5. COMPLETE EXAMPLE IN CONTROLLER
// ============================================

/*
import 'package:get/get.dart';
import '../network/api_service.dart';
import '../constants/api_endpoints.dart';
import '../utils/loading_overlay.dart';
import '../utils/route_helper.dart';
import '../constants/app_routes.dart';

class MyController extends GetxController {
  final ProductApiService _apiService = ProductApiService();
  
  // Fetch data with automatic loading
  Future<void> fetchProducts() async {
    try {
      final response = await _apiService.getProducts(
        filters: {'category': 'rings'},
      );
      
      if (response.statusCode == 200) {
        // Handle success
        print('Products: ${response.data}');
      }
    } catch (e) {
      // Handle error
      Get.snackbar('Error', 'Failed to fetch products');
    }
  }
  
  // Manual loading control
  Future<void> createProduct(Map<String, dynamic> data) async {
    LoadingOverlay.show(message: 'Creating product...');
    
    try {
      final response = await _apiService.createProduct(data);
      
      if (response.statusCode == 201) {
        LoadingOverlay.hide();
        Get.snackbar('Success', 'Product created successfully');
        RouteHelper.back(result: {'created': true});
      }
    } catch (e) {
      LoadingOverlay.hide();
      Get.snackbar('Error', 'Failed to create product');
    }
  }
  
  // Navigate to details
  void goToProductDetails(String productId) {
    RouteHelper.toNamed(
      AppRoutes.productDetails,
      arguments: {'productId': productId},
    );
  }
}
*/

// ============================================
// 6. USAGE IN UI/WIDGET
// ============================================

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/route_helper.dart';
import '../constants/app_routes.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to login
        RouteHelper.toNamed(AppRoutes.login);
      },
      child: Text('Go to Login'),
    );
  }
}
*/

// ============================================
// 7. CHANGE BASE URL
// ============================================

/*
To change the base URL, edit:
lib/core/constants/api_endpoints.dart

Change this line:
static const String baseUrl = 'https://your-api-domain.com/api/v1';

To your actual API URL:
static const String baseUrl = 'https://api.yourapp.com/v1';
*/
