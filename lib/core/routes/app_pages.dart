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
import 'package:digital_jeweller/features/auth/login/presentation/bindings/login_binding.dart';
import 'package:digital_jeweller/features/master_admin/presentation/binding/master_admin_binding.dart';
import 'package:digital_jeweller/features/master_admin/presentation/pages/dashboard/master_admin_dashboard_page.dart';
import 'package:digital_jeweller/features/master_admin/presentation/pages/master_admin_home_page.dart';
import 'package:digital_jeweller/features/user/presentation/bindings/user_dashboard_binding.dart';
import 'package:digital_jeweller/features/user/presentation/pages/user_dashboard.dart';
import 'package:get/get.dart';
import '../../features/admin/presentation/customer_add_update/binding/admin_add_update_binding.dart';
import 'package:digital_jeweller/features/user/presentation/bindings/user_binding.dart';
import '../constants/app_routes.dart';

// Auth Feature
import '../../features/auth/login/presentation/pages/login_page.dart';

// Master Admin Feature
import '../../features/master_admin/presentation/pages/subscription/subscription_plans_page.dart';

// Super Admin Feature
import '../../features/super_admin/presentation/pages/super_admin_web_layout.dart';
import '../../features/super_admin/presentation/controllers/super_admin_dashboard_binding.dart';

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
      page: () => const LoginPage(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    // ==================== MASTER ADMIN ROUTES ====================
    GetPage(
      name: AppRoutes.masterAdminHome,
      page: () => MasterAdminHomePage(),
      binding: MasterAdminBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.masterAdminDashboard,
      page: () => const MasterAdminDashboardPage(),
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
    // GetPage(
    //   name: AppRoutes.masterAdminProfile,
    //   page: () => const MasterAdminProfilePage(),
    //   transition: Transition.rightToLeft,
    //   transitionDuration: const Duration(milliseconds: 300),
    // ),

    // ==================== SUPER ADMIN ROUTES ====================
    GetPage(
      name: AppRoutes.superAdminWebDashboard,
      page: () => const SuperAdminWebLayout(),
      binding: SuperAdminDashboardBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // ==================== ADMIN ROUTES ====================
    GetPage(
      name: AppRoutes.jewellerHome,
      page: () => const JewellerHomePage(),
      bindings: [
        AdminDashboardBinding(),
        // AdminCustomerListBinding(),
        // This should be from customer_add_update if that's what's used
        // SchemeBinding(),
      ],
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.adminDashboard,
      page: () => const JewellerDashboardPage(),
      bindings: [
        AdminDashboardBinding(),
        // AdminCustomerListBinding(),
        // SchemeBinding(),
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
      page: () => CustomerAddUpdatePage(),
      arguments: Get.arguments,
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
      name: AppRoutes.profile,
      page: () => const CommonProfilePage(),
      binding: LoginBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
