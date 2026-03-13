# Master Admin Test Suite

This directory contains comprehensive tests for the Master Admin feature, including jeweller management functionality.

## Quick Start

### Windows
```bash
cd test/features/master_admin
run_tests.bat
```

### Manual Execution
```bash
# 1. Generate mocks
dart run build_runner build --delete-conflicting-outputs

# 2. Run all tests
flutter test test/features/master_admin/

# 3. Run with coverage
flutter test --coverage
```

## Test Structure

```
test/features/master_admin/
├── jeweller_management/
│   ├── domain/
│   │   └── usecases/          # Business logic tests
│   ├── presentation/           # UI/Widget tests
│   └── jeweller_integration_test.dart
├── API_TEST_COLLECTION.md      # Postman/API test collection
├── JEWELLER_TESTING_GUIDE.md   # Comprehensive testing guide
├── TEST_SUMMARY.md             # Summary of fixes and tests
├── README.md                   # This file
└── run_tests.bat               # Automated test runner
```

## Test Categories

### 1. Widget Tests
Test UI components and user interactions:
- Master Admin Home Page (Scaffold, Bottom Navigation)
- Jeweller List Page
- Add Jeweller Page
- Jeweller Details Page

### 2. Use Case Tests
Test business logic with mocked dependencies:
- Get Jewellers
- Create Jeweller (with validation)
- Delete Jeweller
- Toggle Jeweller Status

### 3. Integration Tests
Test dependency injection and service locator:
- Service registration
- Singleton behavior
- Dependency resolution

## Running Specific Tests

### Run Widget Tests Only
```bash
flutter test test/features/master_admin/jeweller_management/presentation/
```

### Run Use Case Tests Only
```bash
flutter test test/features/master_admin/jeweller_management/domain/usecases/
```

### Run Integration Tests Only
```bash
flutter test test/features/master_admin/jeweller_management/jeweller_integration_test.dart
```

### Run Single Test File
```bash
flutter test test/features/master_admin/jeweller_management/presentation/master_admin_home_page_test.dart
```

## Test Coverage

Generate and view coverage report:
```bash
flutter test --coverage
```

Coverage goals:
- Use Cases: 95%+
- Repositories: 90%+
- Services: 90%+
- Controllers: 80%+
- Overall: 85%+

## Issues Fixed

### 1. Scaffold & Bottom Navigation
- ✅ Added missing `key` parameter to MasterAdminHomePage
- ✅ Fixed bottom navigation bar rendering
- ✅ Fixed FAB visibility on Jewellers tab

### 2. Deprecated APIs
- ✅ Replaced `activeColor` with `activeTrackColor` in Switch widget

### 3. Service Locator
- ✅ Registered all missing services
- ✅ Registered all missing repositories
- ✅ Registered all missing use cases

## Dependencies

Test dependencies in `pubspec.yaml`:
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.4
  build_runner: ^2.4.13
```

## Mock Generation

Mocks are generated using Mockito and build_runner:
```bash
dart run build_runner build --delete-conflicting-outputs
```

This generates `.mocks.dart` files alongside test files that use `@GenerateMocks` annotation.

## Test Data

Sample test data is defined in each test file. For API testing, see:
- `API_TEST_COLLECTION.md` - Postman collection
- `JEWELLER_TESTING_GUIDE.md` - Manual testing guide

## Troubleshooting

### Mock Generation Fails
```bash
# Clean and rebuild
flutter clean
flutter pub get
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

### Tests Fail Due to Missing Dependencies
```bash
# Ensure service locator is initialized
await setupLocator();

# Reset after tests
sl.reset();
```

### GetStorage Errors
```bash
# Initialize in test setup
TestWidgetsFlutterBinding.ensureInitialized();
await GetStorage.init();
```

## Best Practices

1. **Arrange-Act-Assert**: Structure tests clearly
2. **Mock External Dependencies**: Use Mockito for repositories/services
3. **Test Edge Cases**: Empty data, null values, errors
4. **Descriptive Names**: Test names should describe what they test
5. **Independent Tests**: Each test should be self-contained
6. **Clean Up**: Reset state in tearDown methods

## CI/CD Integration

For GitHub Actions or other CI systems:
```yaml
- name: Run Tests
  run: flutter test

- name: Generate Coverage
  run: flutter test --coverage

- name: Upload Coverage
  uses: codecov/codecov-action@v2
  with:
    files: ./coverage/lcov.info
```

## Documentation

- **API Testing**: See `API_TEST_COLLECTION.md`
- **Manual Testing**: See `JEWELLER_TESTING_GUIDE.md`
- **Test Summary**: See `TEST_SUMMARY.md`

## Status

✅ All code issues fixed
✅ All tests created
✅ Service locator configured
✅ Ready for execution

---

**Last Updated**: March 9, 2026
**Maintained By**: Development Team
