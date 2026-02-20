import 'package:digital_jeweller/core/bindings/add_banner_binding.dart';
import 'package:digital_jeweller/core/widgets/common_profile_page.dart';
import 'package:digital_jeweller/features/admin/presentation/customer_add_update/admin_customer_list_page.dart';
import 'package:digital_jeweller/features/admin/presentation/customer_add_update/binding/admin_customer_list_binding.dart';
import 'package:digital_jeweller/features/admin/presentation/customer_add_update/customer_add_update_page.dart';
import 'package:digital_jeweller/features/admin/presentation/dashboard/admin_dashboard_binding.dart';
import 'package:digital_jeweller/features/admin/presentation/dashboard/jeweller_dashboard_page.dart';
import 'package:digital_jeweller/features/admin/presentation/dashboard/pages/admin_home_view.dart';
import 'package:digital_jeweller/features/admin/presentation/pages/add_banner_page.dart';
import 'package:digital_jeweller/features/admin/presentation/schemes/binding/scheme_binding.dart';
import 'package:digital_jeweller/features/admin/presentation/schemes/pages/admin_schemes_list_page.dart';
import 'package:digital_jeweller/features/admin/presentation/schemes/pages/admin_scheme_add_update.dart';
import 'package:digital_jeweller/features/auth/presentation/binding/auth_biniding.dart';
import 'package:digital_jeweller/features/master_admin/presentation/binding/master_admin_binding.dart';
import 'package:digital_jeweller/features/user/presentation/bindings/user_dashboard_binding.dart';
import 'package:digital_jeweller/features/user/presentation/pages/user_dashboard.dart';
import 'package:get/get.dart';
import '../../features/admin/presentation/customer_add_update/binding/admin_add_update_binding.dart';
import 'package:digital_jeweller/features/user/presentation/bindings/user_binding.dart';
import '../constants/app_routes.dart';

// Auth Feature
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/forgot_password_screen.dart';

// Master Admin Feature
import '../../features/master_admin/presentation/pages/master_admin_dashboard.dart';
import '../../features/master_admin/presentation/pages/subscription_plans_page.dart';
import '../../features/master_admin/presentation/pages/master_admin_profile_page.dart';

// Admin Feature
import '../../features/admin/presentation/pages/banner_management_page.dart';

// User Feature
import '../../features/user/presentation/pages/customer_home_page.dart';

/// GetX Pages Configuration with all routes
class AppPages {
  static final routes = [
    // ==================== AUTH ROUTES ====================
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // ==================== MASTER ADMIN ROUTES ====================
    GetPage(
      name: AppRoutes.masterAdminDashboard,
      page: () => const MasterAdminDashboard(),
      binding: MasterAdminBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.masterAdminJewellerList,
      page: () => const AdminCustomerListPage(),
      binding: MasterAdminBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.masterAdminJewellerAddUpdate,
      page: () => const AdminCustomerListPage(),
      binding: MasterAdminBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.masterAdminSubscriptionPlans,
      page: () => const SubscriptionPlansPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.masterAdminProfile,
      page: () => const MasterAdminProfilePage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // ==================== ADMIN ROUTES ====================
    GetPage(
      name: AppRoutes.jewellerHome,
      page: () => const jewellerHomePage(),
      bindings: [
        AdminDashboardBinding(),
        AdminCustomerListBinding(), // This should be from customer_add_update if that's what's used
        SchemeBinding(),
      ],
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.adminDashboard,
      page: () => const JewellerDashboardPage(),
      bindings: [
        AdminDashboardBinding(),
        AdminCustomerListBinding(),
        SchemeBinding(),
      ],
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.adminUserList,
      page: () => const AdminCustomerListPage(),
      binding: AdminCustomerListBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: AppRoutes.adminAddUser,
      page: () => CustomerAddUpdatePage(
        customer: Get.arguments, // Accept customer from arguments
      ),
      binding: AdminCustomerAddUpdateBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.adminListScheme,
      page: () => const AdminSchemesListPage(),
      binding: SchemeBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.adminAddUpdateScheme,
      page: () => AdminSchemeAddUpdatePage(),
      arguments: Get.arguments,
      binding: SchemeBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.adminBannerManagement,
      page: () => const BannerManagementPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.adminAddBanner,
      page: () => const AddBannerPage(),
      binding: AddBannerBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // ==================== USER ROUTES ====================
    GetPage(
      name: AppRoutes.userHomeScreen,
      page: () => const CustomerHomePage(),
      binding: UserBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.userDashboard,
      page: () => const UserDashboard(),
      binding: UserDashboardBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.userDashboardHome,
      page: () => const UserDashboard(),
      binding: UserDashboardBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.userProfile,
      page: () => const CommonProfilePage(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
