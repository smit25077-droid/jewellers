@echo off
echo ========================================
echo Master Admin Test Suite
echo ========================================
echo.

echo Step 1: Generating Mock Files...
echo ----------------------------------------
dart run build_runner build --delete-conflicting-outputs
if %errorlevel% neq 0 (
    echo Mock generation failed!
    pause
    exit /b %errorlevel%
)
echo Mock files generated successfully!
echo.

echo Step 2: Running Service Locator Tests...
echo ----------------------------------------
flutter test test/core/service_locator_enforcer_test.dart
if %errorlevel% neq 0 (
    echo Service locator tests failed!
    pause
    exit /b %errorlevel%
)
echo Service locator tests passed!
echo.

echo Step 3: Running Integration Tests...
echo ----------------------------------------
flutter test test/features/master_admin/jeweller_management/jeweller_integration_test.dart
if %errorlevel% neq 0 (
    echo Integration tests failed!
    pause
    exit /b %errorlevel%
)
echo Integration tests passed!
echo.

echo Step 4: Running Use Case Tests...
echo ----------------------------------------
flutter test test/features/master_admin/jeweller_management/domain/usecases/
if %errorlevel% neq 0 (
    echo Use case tests failed!
    pause
    exit /b %errorlevel%
)
echo Use case tests passed!
echo.

echo Step 5: Running Widget Tests...
echo ----------------------------------------
flutter test test/features/master_admin/jeweller_management/presentation/
if %errorlevel% neq 0 (
    echo Widget tests failed!
    pause
    exit /b %errorlevel%
)
echo Widget tests passed!
echo.

echo Step 6: Running All Master Admin Tests...
echo ----------------------------------------
flutter test test/features/master_admin/
if %errorlevel% neq 0 (
    echo Some tests failed!
    pause
    exit /b %errorlevel%
)
echo.

echo ========================================
echo All Tests Passed Successfully!
echo ========================================
echo.

echo Generating Coverage Report...
echo ----------------------------------------
flutter test --coverage
echo.

echo ========================================
echo Test Suite Complete!
echo ========================================
pause
