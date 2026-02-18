# Digital Jeweller - Quick Start Guide

## 🚀 Getting Started

### Prerequisites
- Flutter SDK installed
- Android Studio / VS Code
- Android Emulator or Physical Device

### Installation

1. **Clone/Open the project**
   ```bash
   cd d:/FlutterProject/digital_jeweller
   ```

2. **Get dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # On Android
   flutter run

   # On specific device
   flutter run -d <device-id>

   # Check available devices
   flutter devices
   ```

## 🧪 Testing the Application

### Test Flow 1: Authentication
1. App starts at Login Screen
2. Click "Register" → Navigate to Register Screen
3. Click "Back" → Return to Login Screen
4. Click "Forgot Password" → Navigate to Forgot Password Screen
5. Click "Back" → Return to Login Screen

### Test Flow 2: Master Admin
1. Login as Master Admin (role: super_admin)
2. Navigate to Dashboard
3. Click on navigation items:
   - Dashboard
   - Jewellers List
   - Subscription Plans
   - Profile

### Test Flow 3: Admin
1. Login as Admin (role: jewellers_admin)
2. Navigate to Dashboard
3. Test navigation:
   - Add User
   - Add Scheme
   - Banner Management

### Test Flow 4: User
1. Login as User (role: customer)
2. Navigate to Dashboard
3. Click Profile
4. Test profile options

### Test Flow 5: Theme Switching
1. Open app
2. Change system theme (Light/Dark)
3. Verify colors update correctly
4. Check all screens maintain consistency

## 📱 Navigation Examples

### Using Route Names
```dart
// Navigate to a screen
Get.toNamed(AppRoutes.userProfile);

// Navigate and remove previous routes
Get.offAllNamed(AppRoutes.login);

// Navigate with arguments
Get.toNamed(
  AppRoutes.userProfile,
  arguments: {'userId': 123},
);

// Get arguments in destination
final args = Get.arguments;
final userId = args['userId'];
```

### Using Direct Navigation
```dart
// Navigate to widget
Get.to(() => UserProfilePage());

// Navigate and remove previous
Get.off(() => LoginScreen());

// Navigate and remove all previous
Get.offAll(() => LoginScreen());
```

## 🎨 Customizing Theme

### Change Primary Color
Edit `lib/core/theme/app_colors.dart`:
```dart
static const Color primary = Color(0xFFCFB53B); // Change this
```

### Add New Color
```dart
static const Color myNewColor = Color(0xFF123456);
```

### Use Color in Widget
```dart
Container(
  color: AppColors.primary,
  // or
  color: AppColors.myNewColor,
)
```

## 🔧 Adding New Features

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

### Step 2: Create Controller
```dart
class MyFeatureController extends BaseController {
  final data = [].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    try {
      showLoading();
      // Load data
      showSuccess('Data loaded');
    } catch (e) {
      showError('Failed to load data');
    } finally {
      hideLoading();
    }
  }
}
```

### Step 3: Create Page
```dart
class MyFeaturePage extends StatelessWidget {
  const MyFeaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MyFeatureController>();

    return Scaffold(
      appBar: AppBar(title: const Text('My Feature')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const CommonLoading();
        }

        if (controller.data.isEmpty) {
          return EmptyState(
            icon: Icons.inbox,
            title: 'No data',
          );
        }

        return ListView.builder(
          itemCount: controller.data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(controller.data[index]),
            );
          },
        );
      }),
    );
  }
}
```

### Step 4: Add Route
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

### Step 5: Register Controller
```dart
// In main.dart
Get.put(MyFeatureController());
```

## 🐛 Troubleshooting

### Issue: Hot Reload Not Working
```bash
# Press 'R' in terminal for hot restart
# Or run:
flutter run
```

### Issue: Build Errors
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

### Issue: Gradle Build Failed
```bash
# In android folder
cd android
./gradlew clean
cd ..
flutter run
```

### Issue: Dependencies Not Found
```bash
flutter pub get
flutter pub upgrade
```

## 📊 Project Statistics

- **Total Files**: 50+ Dart files
- **Features**: 4 (Auth, Master Admin, Admin, User)
- **Common Widgets**: 10+
- **Routes**: 15+
- **Base Classes**: 3 (Controller, Service, Repository)
- **Exception Types**: 6
- **Failure Types**: 6

## 🎯 Best Practices

1. **Always extend base classes**
   - Controllers → BaseController
   - Services → BaseService
   - Repositories → BaseRepository

2. **Use route constants**
   ```dart
   // Good
   Get.toNamed(AppRoutes.userProfile);
   
   // Bad
   Get.toNamed('/user/profile');
   ```

3. **Handle errors properly**
   ```dart
   try {
     showLoading();
     await doSomething();
     showSuccess('Done!');
   } catch (e) {
     showError('Error: $e');
   } finally {
     hideLoading();
   }
   ```

4. **Use common widgets**
   ```dart
   // Good
   CommonLoading(message: 'Loading...')
   
   // Bad
   CircularProgressIndicator()
   ```

5. **Follow clean architecture**
   - Keep layers separated
   - Data → Domain → Presentation
   - No direct dependencies on lower layers

## 📞 Support

For issues or questions:
1. Check ARCHITECTURE.md for detailed documentation
2. Check IMPLEMENTATION_SUMMARY.md for feature list
3. Review code comments in the codebase

## 🎉 You're Ready!

Your Digital Jeweller app is now set up with:
- ✅ Clean Architecture
- ✅ GetX State Management
- ✅ Complete Routing System
- ✅ Beautiful Theme (Light/Dark)
- ✅ Common Widgets
- ✅ Error Handling
- ✅ All User Flows

**Happy Coding! 🚀**
