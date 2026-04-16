/// Application Routes Configuration
class AppRoutes {
  // ==================== AUTH ROUTES ====================
  static const String login = '/login';
  static const String profile = '/profile';

  // ==================== MASTER ADMIN ROUTES ====================
  static const String masterAdminHome = '/master-admin/home';
  static const String masterAdminDashboard = '/master-admin/dashboard';
  static const String masterAdminJewellerList = '/master-admin/jewellers';
  static const String masterAdminJewellerAddUpdate =
      '/master-admin/jewellers/add-update';
  static const String masterAdminSubscriptionPlans = '/master-admin/plans';
  
  // ==================== SUPER ADMIN ROUTES ====================
  static const String superAdminWebDashboard = '/super-admin/web-dashboard';

  // ==================== ADMIN ROUTES ====================
  static const String jewellerHome = '/admin/home';
  static const String adminDashboard = '/admin/dashboard';
  static const String adminAddUser = '/admin/users/add';
  static const String adminUserList = '/admin/users';
  static const String adminUserDetails = '/admin/users/details';
  static const String adminListScheme = '/admin/schemes/List';
  static const String adminAddUpdateScheme = '/admin/schemes/add/update';
  static const String adminSchemeList = '/admin/schemes';
  static const String adminSchemeDetails = '/admin/schemes/details';
  static const String adminBannerManagement = '/admin/banners';
  static const String adminAddBanner = '/admin/banners/add';

  // ==================== USER ROUTES ====================
  static const String userHomeScreen = '/user/home-screen';
  static const String userDashboard = '/user/dashboard';
  static const String userDashboardHome = '/user/dashboard/home';
  static const String userSchemes = '/user/schemes';
  static const String userSchemeDetails = '/user/schemes/details';

}
