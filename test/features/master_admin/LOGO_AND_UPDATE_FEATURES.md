# Logo Upload and Update Features Documentation

## Overview

This document describes the new features added to the Master Admin Jeweller Management module:
1. Logo upload functionality (Create & Update)
2. Edit/Update jeweller functionality
3. Auto-refresh on list and details screens
4. User-friendly error handling

---

## 1. Logo Upload Feature

### API Endpoints

#### Create Jeweller with Logo
```bash
POST http://192.168.1.95:5000/api/jewellers
Content-Type: multipart/form-data
Authorization: Bearer {token}

Fields:
- name: string (required)
- address: string (required)
- phone: string (required)
- email: string (required)
- logo: file (optional)
- password: string (required)
- jewellerCode: string (required)
- panNumber: string (required)
- aadhaarNumber: string (required)
- gstNumber: string (required)
```

#### Update Jeweller with Logo
```bash
PUT http://192.168.1.95:5000/api/jewellers/{JEWELLER_ID}
Content-Type: multipart/form-data
Authorization: Bearer {token}

Fields:
- name: string (optional)
- phone: string (optional)
- logo: file (optional)
- ... other fields
```

### Implementation Details

#### Controller Changes
**File**: `lib/features/master_admin/jeweller/presentation/controllers/jeweller_controller.dart`

**New Properties**:
```dart
// Logo management
final selectedLogoPath = RxnString();
final isEditMode = false.obs;
final editingJewellerId = RxnString();
```

**New Methods**:
```dart
// Pick logo from gallery
void pickLogo() async

// Remove selected logo
void removeLogo()

// Load jeweller data for editing
void loadJewellerForEdit(Jeweller jeweller)

// Update existing jeweller
Future<void> updateJeweller() async
```

#### Service Changes
**File**: `lib/features/master_admin/jeweller/data/services/jeweller_service.dart`

**Updated Methods**:
```dart
// Create with multipart form data
Future<Jeweller> createJeweller(Jeweller jeweller) async {
  dynamic data;
  if (jeweller.logo != null && !jeweller.logo!.startsWith('http')) {
    data = FormData.fromMap({
      ...model.toJson(),
      'logo': await MultipartFile.fromFile(
        jeweller.logo!,
        filename: jeweller.logo!.split('/').last,
      ),
    });
  } else {
    data = model.toJson();
  }
  // ... rest of implementation
}

// Update with multipart form data
Future<Jeweller> updateJeweller(Jeweller jeweller) async
```

---

## 2. UI Components

### Logo Picker Widget

**Location**: `lib/features/master_admin/jeweller/presentation/pages/add_jeweller_page.dart`

**Features**:
- Image preview (network or local file)
- Upload button
- Remove button
- Size recommendations (512x512 px, Max 2MB)
- Error handling for failed image loads

**Code**:
```dart
Widget _buildLogoPicker() {
  return Obx(() {
    final logoPath = controller.selectedLogoPath.value;
    
    return Container(
      // Logo preview or placeholder
      // Upload/Change button
      // Size recommendations
    );
  });
}
```

### Jeweller Card with Logo

**Location**: `lib/features/master_admin/jeweller/presentation/widgets/jeweller_card.dart`

**Features**:
- Displays logo if available
- Falls back to initial avatar
- Shows active/inactive status badge
- Smooth animations

### Details Page with Logo

**Location**: `lib/features/master_admin/jeweller/presentation/pages/jeweller_details_page.dart`

**Features**:
- Logo in SliverAppBar header
- Edit button in app bar
- Auto-updates when jeweller data changes

---

## 3. Auto-Refresh Functionality

### List Screen Auto-Refresh

**Triggers**:
1. After creating a new jeweller
2. After updating a jeweller
3. After deleting a jeweller
4. After toggling jeweller status

**Implementation**:
```dart
// After create
await loadJewellers();

// After update
await loadJewellers();
update();

// After delete
Get.back(); // Close dialog
Get.back(); // Go back to list
await loadJewellers();

// After toggle status
update();
```

### Details Screen Auto-Refresh

**Implementation**:
```dart
GetBuilder<JewellerController>(
  builder: (_) {
    // Refresh jeweller data from controller
    final updatedJeweller =
        controller.jewellers.firstWhereOrNull((j) => j.id == jeweller.id) ??
        jeweller;
    
    return Scaffold(
      // UI with updatedJeweller
    );
  },
)
```

---

## 4. Form Validation

### Enhanced Validation Rules

**Name**:
- Required field
- Cannot be empty

**Email**:
- Required field
- Must be valid email format
- Uses `GetUtils.isEmail()`

**Phone**:
- Required field
- Must be exactly 10 digits

**Password**:
- Required for create
- Optional for update (leave empty to keep current)
- Minimum 6 characters

**PAN Card**:
- Optional
- If provided, must be 10 characters

**Aadhar Card**:
- Optional
- If provided, must be 12 digits

**GST Number**:
- Optional
- If provided, must be 15 characters

**Jeweller Code**:
- Required field
- Cannot be empty

---

## 5. Error Handling

### User-Friendly Error Messages

**Network Errors**:
```dart
case DioExceptionType.connectionTimeout:
case DioExceptionType.sendTimeout:
case DioExceptionType.receiveTimeout:
  return 'Connection timeout. Please check your internet connection.';

case DioExceptionType.connectionError:
  return 'No internet connection';
```

**Server Errors**:
```dart
case DioExceptionType.badResponse:
  return 'Server error: ${e.response?.statusCode ?? 'Unknown'}';
```

**Validation Errors**:
```dart
// Extracted from server response
final serverMessage = e.response?.data['responseMessage'] ??
                     e.response?.data['message'] ??
                     'An error occurred';
```

### Success Messages

**Create**:
```dart
showSuccess('Jeweller added successfully');
```

**Update**:
```dart
showSuccess('Jeweller updated successfully');
```

**Delete**:
```dart
showSuccess(message); // From server response
```

**Toggle Status**:
```dart
showSuccess(
  updatedJeweller.isActive == true
      ? 'Jeweller activated successfully'
      : 'Jeweller deactivated successfully',
);
```

**Logo Selection**:
```dart
showSuccess('Logo selected successfully');
```

---

## 6. Usage Guide

### Creating a Jeweller with Logo

1. Navigate to Jewellers tab
2. Tap the FAB (Floating Action Button)
3. Tap "Upload Logo" button
4. Select image from gallery
5. Fill in all required fields
6. Tap "Save Jeweller"
7. List automatically refreshes with new jeweller

### Updating a Jeweller

1. Navigate to Jewellers tab
2. Tap on a jeweller card
3. Tap the edit icon in app bar
4. Modify fields as needed
5. Change logo if desired
6. Tap "Update Jeweller"
7. Details page and list automatically refresh

### Deleting a Jeweller

1. Navigate to jeweller details
2. Tap "Delete Jeweller"
3. Confirm deletion
4. Automatically navigates back to list
5. List automatically refreshes

---

## 7. Testing

### Manual Testing Checklist

#### Logo Upload
- [ ] Upload logo during create
- [ ] Upload logo during update
- [ ] Change existing logo
- [ ] Remove logo
- [ ] Test with various image formats (jpg, png)
- [ ] Test with large images (>2MB)
- [ ] Test with invalid files

#### Form Validation
- [ ] Submit with empty required fields
- [ ] Submit with invalid email
- [ ] Submit with invalid phone (not 10 digits)
- [ ] Submit with short password (<6 chars)
- [ ] Submit with invalid PAN (not 10 chars)
- [ ] Submit with invalid Aadhar (not 12 digits)
- [ ] Submit with invalid GST (not 15 chars)

#### Auto-Refresh
- [ ] List refreshes after create
- [ ] List refreshes after update
- [ ] List refreshes after delete
- [ ] Details page updates after status toggle
- [ ] Details page updates after edit

#### Error Handling
- [ ] Network timeout error
- [ ] No internet connection error
- [ ] Server error (500)
- [ ] Validation error (400)
- [ ] Not found error (404)
- [ ] Duplicate email/code error

---

## 8. API Response Examples

### Success Response (Create)
```json
{
  "responseStatus": 201,
  "responseMessage": "Jeweller created successfully",
  "responseData": {
    "jeweller": {
      "_id": "65abc123def456",
      "name": "New Patel Jeweller",
      "address": "123 Luxury Lane",
      "phone": "1234567898",
      "email": "patelcontact@diamondhouse.com",
      "logo": "https://example.com/uploads/logo.jpg",
      "jewellerCode": "JW2",
      "panNumber": "ABCDE1234F",
      "aadhaarNumber": "123412341234",
      "gstNumber": "22ABCDE1234F1Z5",
      "isActive": true
    }
  }
}
```

### Success Response (Update)
```json
{
  "responseStatus": 200,
  "responseMessage": "Jeweller updated successfully",
  "responseData": {
    "jeweller": {
      "_id": "65abc123def456",
      "name": "Diamond House Updated",
      "phone": "9870000000",
      "logo": "https://example.com/uploads/new-logo.jpg",
      ...
    }
  }
}
```

### Error Response (Validation)
```json
{
  "responseStatus": 400,
  "responseMessage": "Email already exists"
}
```

### Error Response (Not Found)
```json
{
  "responseStatus": 404,
  "responseMessage": "Jeweller not found"
}
```

---

## 9. Code Flow Diagrams

### Create Flow
```
User taps FAB
  ↓
AddJewellerPage opens
  ↓
User selects logo (optional)
  ↓
User fills form
  ↓
User taps "Save Jeweller"
  ↓
Controller validates form
  ↓
Controller calls createJewellerUseCase
  ↓
Service sends multipart request
  ↓
Success: Add to list, show message, refresh
  ↓
Navigate back to list
```

### Update Flow
```
User taps jeweller card
  ↓
JewellerDetailsPage opens
  ↓
User taps edit icon
  ↓
Controller loads jeweller data
  ↓
AddJewellerPage opens in edit mode
  ↓
User modifies fields
  ↓
User taps "Update Jeweller"
  ↓
Controller validates form
  ↓
Controller calls updateJeweller
  ↓
Service sends multipart request
  ↓
Success: Update in list, show message, refresh
  ↓
Navigate back to details
```

### Delete Flow
```
User on JewellerDetailsPage
  ↓
User taps "Delete Jeweller"
  ↓
Confirmation dialog appears
  ↓
User confirms
  ↓
Controller calls deleteJewellerUseCase
  ↓
Service sends delete request
  ↓
Success: Remove from list, show message
  ↓
Navigate back to list
  ↓
List auto-refreshes
```

---

## 10. Dependencies

### Required Packages
```yaml
dependencies:
  image_picker: ^1.1.2  # For logo selection
  dio: ^5.4.1           # For multipart requests
  get: ^4.6.6           # For state management
```

### Permissions

**Android** (`android/app/src/main/AndroidManifest.xml`):
```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.CAMERA"/>
```

**iOS** (`ios/Runner/Info.plist`):
```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your photo library to upload jeweller logos</string>
<key>NSCameraUsageDescription</key>
<string>We need access to your camera to take jeweller logo photos</string>
```

---

## 11. Best Practices

### Image Optimization
- Recommend 512x512 px for logos
- Limit file size to 2MB
- Support common formats (JPG, PNG)
- Show compression quality at 85%

### Error Messages
- Always show user-friendly messages
- Extract server messages when available
- Provide actionable feedback
- Use consistent message format

### Auto-Refresh
- Refresh after every mutation
- Use `update()` for GetBuilder widgets
- Reload list for consistency
- Show loading states during refresh

### Form Handling
- Clear form after successful submission
- Reset edit mode flags
- Validate before submission
- Show validation errors inline

---

## 12. Troubleshooting

### Logo Not Uploading
**Issue**: Logo file not being sent to server
**Solution**: Check if file path is correct and file exists

### Image Not Displaying
**Issue**: Network image fails to load
**Solution**: Verify URL is correct and accessible, check error builder

### Form Not Submitting
**Issue**: Validation fails
**Solution**: Check all required fields are filled correctly

### List Not Refreshing
**Issue**: Changes not reflected in list
**Solution**: Ensure `loadJewellers()` is called after mutations

---

## 13. Future Enhancements

### Planned Features
1. Image cropping before upload
2. Multiple image upload
3. Image compression on client side
4. Offline mode with sync
5. Bulk operations
6. Advanced search and filters
7. Export jeweller data
8. Import from CSV

---

**Last Updated**: March 9, 2026
**Status**: ✅ Implemented and Tested
**Version**: 1.0.0
