# Jeweller Management Testing Guide

## Overview

This guide provides comprehensive testing instructions for the Jeweller Management feature in the Master Admin module.

---

## Test Structure

```
test/features/master_admin/jeweller_management/
├── data/
│   └── datasources/
│       └── jeweller_remote_datasource_test.dart
├── domain/
│   └── usecases/
│       ├── get_jewellers_usecase_test.dart
│       ├── create_jeweller_usecase_test.dart
│       ├── delete_jeweller_usecase_test.dart
│       └── toggle_jeweller_status_usecase_test.dart
└── jeweller_integration_test.dart
```

---

## Running Tests

### Run All Tests
```bash
flutter test
```

### Run Specific Test File
```bash
flutter test test/features/master_admin/jeweller_management/data/datasources/jeweller_remote_datasource_test.dart
```

### Run Integration Tests
```bash
flutter test test/features/master_admin/jeweller_management/jeweller_integration_test.dart
```

### Run with Coverage
```bash
flutter test --coverage
```

---

## Test Categories

### 1. Data Source Tests
**File**: `jeweller_remote_datasource_test.dart`

Tests the API communication layer:
- ✅ GET /jewellers - Fetch all jewellers
- ✅ POST /jewellers - Create new jeweller
- ✅ DELETE /jewellers/:id - Delete jeweller
- ✅ PUT /jewellers/:id - Toggle jeweller status

**Test Scenarios**:
- Success responses (200, 201)
- Error responses (400, 404, 500)
- Network errors (timeout, connection error)
- Data parsing and transformation

### 2. Use Case Tests
**Files**: 
- `get_jewellers_usecase_test.dart`
- `create_jeweller_usecase_test.dart`
- `delete_jeweller_usecase_test.dart`
- `toggle_jeweller_status_usecase_test.dart`

Tests business logic layer:
- ✅ Input validation
- ✅ Repository interaction
- ✅ Error handling
- ✅ Data transformation

### 3. Integration Tests
**File**: `jeweller_integration_test.dart`

Tests the complete dependency injection setup:
- ✅ Service locator registration
- ✅ Dependency resolution
- ✅ Singleton behavior
- ✅ Shared instances

---

## Manual API Testing

### Prerequisites
1. Backend server running
2. Valid authentication token
3. API base URL configured

### Test Flow

#### 1. Get All Jewellers
```bash
GET /jewellers
Headers:
  Authorization: Bearer <token>
  Content-Type: application/json

Expected Response (200):
{
  "responseStatus": 200,
  "responseMessage": "Jewellers retrieved",
  "responseData": {
    "count": 2,
    "jewellers": [...]
  }
}
```

#### 2. Create Jeweller
```bash
POST /jewellers
Headers:
  Authorization: Bearer <token>
  Content-Type: application/json

Body:
{
  "name": "Test Jeweller",
  "address": "123 Main St",
  "phone": "1234567890",
  "email": "test@example.com",
  "jewellerCode": "JC001",
  "password": "password123",
  "panNumber": "ABCDE1234F",
  "aadhaarNumber": "123456789012",
  "gstNumber": "22AAAAA0000A1Z5"
}

Expected Response (201):
{
  "responseStatus": 201,
  "responseMessage": "Jeweller created",
  "responseData": {
    "jeweller": {...}
  }
}
```

#### 3. Toggle Jeweller Status
```bash
PUT /jewellers/:id
Headers:
  Authorization: Bearer <token>
  Content-Type: application/json

Body:
{
  "isActive": false
}

Expected Response (200):
{
  "responseStatus": 200,
  "responseMessage": "Status updated",
  "responseData": {
    "jeweller": {...}
  }
}
```

#### 4. Delete Jeweller
```bash
DELETE /jewellers/:id
Headers:
  Authorization: Bearer <token>

Expected Response (200):
{
  "responseStatus": 200,
  "responseMessage": "Jeweller deleted successfully"
}
```

---

## Error Scenarios to Test

### 1. Validation Errors (400)
- Empty required fields
- Invalid email format
- Duplicate jeweller code
- Invalid phone number

**Expected Response**:
```json
{
  "responseStatus": 400,
  "responseMessage": "Validation failed: Email already exists"
}
```

### 2. Not Found (404)
- Invalid jeweller ID
- Deleted jeweller

**Expected Response**:
```json
{
  "responseStatus": 404,
  "responseMessage": "Jeweller not found"
}
```

### 3. Unauthorized (401)
- Missing token
- Expired token
- Invalid token

**Expected Response**:
```json
{
  "responseStatus": 401,
  "responseMessage": "Unauthorized"
}
```

### 4. Server Error (500)
- Database connection failure
- Internal server error

**Expected Response**:
```json
{
  "responseStatus": 500,
  "responseMessage": "Internal server error"
}
```

### 5. Network Errors
- Connection timeout
- No internet connection
- DNS resolution failure

**Expected Behavior**:
- Show user-friendly error message
- Retry option
- Offline mode indication

---

## UI Testing Checklist

### Jeweller List Page
- [ ] Loading state displays correctly
- [ ] Empty state shows when no jewellers
- [ ] Jewellers list displays all items
- [ ] Active/Inactive status shows correctly
- [ ] Pull to refresh works
- [ ] Error messages display properly

### Create Jeweller Form
- [ ] All fields are present
- [ ] Validation works for each field
- [ ] Form submission shows loading state
- [ ] Success message appears after creation
- [ ] Form clears after successful submission
- [ ] Error messages display for validation failures
- [ ] Back button works correctly

### Delete Jeweller
- [ ] Confirmation dialog appears
- [ ] Delete action removes jeweller from list
- [ ] Success message shows
- [ ] Error handling works
- [ ] List refreshes after deletion

### Toggle Status
- [ ] Status toggle button works
- [ ] Loading state during toggle
- [ ] Success message appears
- [ ] UI updates immediately
- [ ] Error handling works

---

## Performance Testing

### Load Testing
- Test with 100+ jewellers
- Measure list rendering time
- Check memory usage
- Verify smooth scrolling

### Network Testing
- Test on slow 3G connection
- Test with intermittent connectivity
- Verify timeout handling
- Check retry mechanisms

---

## Test Data

### Valid Jeweller Data
```dart
{
  "name": "Test Jeweller",
  "address": "123 Main Street, City, State 12345",
  "phone": "1234567890",
  "email": "test@example.com",
  "jewellerCode": "JC001",
  "password": "SecurePass123!",
  "panNumber": "ABCDE1234F",
  "aadhaarNumber": "123456789012",
  "gstNumber": "22AAAAA0000A1Z5"
}
```

### Invalid Test Cases
```dart
// Empty name
{"name": "", ...}

// Invalid email
{"email": "invalid-email", ...}

// Short phone
{"phone": "123", ...}

// Invalid PAN format
{"panNumber": "INVALID", ...}

// Invalid Aadhaar (not 12 digits)
{"aadhaarNumber": "123", ...}
```

---

## Continuous Integration

### GitHub Actions / CI Pipeline
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

---

## Test Coverage Goals

- **Data Sources**: 90%+
- **Repositories**: 90%+
- **Use Cases**: 95%+
- **Controllers**: 80%+
- **Overall**: 85%+

---

## Troubleshooting

### Common Issues

1. **Mock Generation Fails**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

2. **GetStorage Initialization Error**
   - Ensure `GetStorage.init()` is called in `setUpAll()`
   - Use `TestWidgetsFlutterBinding.ensureInitialized()`

3. **Service Locator Not Initialized**
   - Call `setupLocator()` in test setup
   - Reset with `sl.reset()` in teardown

---

## Next Steps

1. ✅ Run all unit tests
2. ✅ Run integration tests
3. ✅ Test manually with Postman/API client
4. ✅ Test UI flows in the app
5. ✅ Check error handling
6. ✅ Verify loading states
7. ✅ Test edge cases
8. ✅ Generate coverage report

---

**Last Updated**: March 2, 2026  
**Status**: Ready for Testing ✅
