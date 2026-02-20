/// Application Routes Configuration
class AppRoutes {
  // ==================== AUTH ROUTES ====================
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String verifyOtp = '/verify-otp';

  // ==================== MASTER ADMIN ROUTES ====================
  static const String masterAdminDashboard = '/master-admin/dashboard';
  static const String masterAdminJewellerList = '/master-admin/jewellers';
  static const String masterAdminJewellerAddUpdate =
      '/master-admin/jewellers/add-update';
  static const String masterAdminSubscriptionPlans = '/master-admin/plans';
  static const String masterAdminProfile = '/master-admin/profile';
  // static const String masterAdminSettings = '/master-admin/settings';

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
  static const String adminPaymentRequests = '/admin/payment-requests';
  static const String adminProfile = '/admin/profile';
  static const String adminSettings = '/admin/settings';

  // ==================== USER ROUTES ====================
  static const String userHomeScreen = '/user/home-screen';
  static const String userDashboard = '/user/dashboard';
  static const String userDashboardHome = '/user/dashboard/home';
  static const String userProfile = '/user/profile';
  static const String userEditProfile = '/user/profile/edit';
  static const String userSchemes = '/user/schemes';
  static const String userSchemeDetails = '/user/schemes/details';
  static const String userPayments = '/user/payments';
  static const String userPaymentHistory = '/user/payments/history';
  static const String userNotifications = '/user/notifications';
  static const String userSettings = '/user/settings';

  // ==================== COMMON ROUTES ====================
  static const String changePassword = '/change-password';
  static const String about = '/about';
  static const String termsAndConditions = '/terms-and-conditions';
  static const String privacyPolicy = '/privacy-policy';
  static const String contactUs = '/contact-us';
  static const String help = '/help';
}
