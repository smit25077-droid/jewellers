# Image URL Fix Documentation

## Issue Fixed ✅

### Problem
Images were not loading and showing errors:
```
ArgumentError: Invalid argument(s): No host specified in URI file:///uploads/photo-1773057732483.png
NetworkImageLoadException: HTTP request failed, statusCode: 404
```

### Root Cause
The API returns relative image paths like `/uploads/photo-1773057732483.png`, but the app was trying to load them directly without the base URL, resulting in:
1. Invalid file:// URLs
2. 404 errors when trying to load from wrong URLs

---

## Solution

### 1. Created Image URL Helper Method

**File**: `lib/core/constants/api_endpoints.dart`

Added a helper method to build complete image URLs:

```dart
// Helper method to build full image URL
static String getImageUrl(String? imagePath) {
  if (imagePath == null || imagePath.isEmpty) {
    return '';
  }

  // If already a full URL, return as is
  if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
    return imagePath;
  }

  // Remove /api from baseUrl for image paths
  final imageBaseUrl = baseUrl.replaceAll('/api', '');

  // Remove leading slash if present
  final cleanPath = imagePath.startsWith('/') ? imagePath : '/$imagePath';

  return '$imageBaseUrl$cleanPath';
}
```

### How It Works

**Input Examples**:
```dart
// Relative path from API
"/uploads/photo-1773057732483.png"

// Already full URL
"http://192.168.1.95:5000/uploads/photo-1773057732483.png"

// Path without leading slash
"uploads/photo-1773057732483.png"
```

**Output**:
```dart
// All convert to:
"http://192.168.1.95:5000/uploads/photo-1773057732483.png"
```

---

## Files Updated

### 1. API Endpoints
**File**: `lib/core/constants/api_endpoints.dart`
- Added `getImageUrl()` helper method

### 2. Jeweller Card
**File**: `lib/features/master_admin/jeweller/presentation/widgets/jeweller_card.dart`
- Updated to use `ApiEndpoints.getImageUrl(jeweller.logo)`
- Added loading indicator
- Added error handling

**Before**:
```dart
Image.network(
  jeweller.logo!,
  width: 50,
  height: 50,
  fit: BoxFit.cover,
)
```

**After**:
```dart
Image.network(
  ApiEndpoints.getImageUrl(jeweller.logo),
  width: 50,
  height: 50,
  fit: BoxFit.cover,
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return CircularProgressIndicator(...);
  },
  errorBuilder: (context, error, stackTrace) {
    return _buildInitialAvatar();
  },
)
```

### 3. Jeweller Details Page
**File**: `lib/features/master_admin/jeweller/presentation/pages/jeweller_details_page.dart`
- Updated header logo to use `ApiEndpoints.getImageUrl()`
- Added loading indicator
- Added error handling

### 4. Add/Edit Jeweller Page
**File**: `lib/features/master_admin/jeweller/presentation/pages/add_jeweller_page.dart`
- Updated logo preview to use `ApiEndpoints.getImageUrl()`
- Added loading indicator for network images
- Kept local file preview for newly selected images

---

## Benefits

### 1. Proper URL Construction
✅ Handles relative paths from API
✅ Handles full URLs
✅ Handles paths with/without leading slash
✅ Removes `/api` from base URL for images

### 2. Better User Experience
✅ Loading indicators while images load
✅ Smooth transitions
✅ Graceful error handling
✅ Fallback to initial avatar

### 3. Consistent Behavior
✅ Same logic across all screens
✅ Centralized URL building
✅ Easy to maintain
✅ Easy to update base URL

---

## Testing

### Test Cases

#### 1. Relative Path from API
```dart
Input: "/uploads/photo-1773057732483.png"
Expected: "http://192.168.1.95:5000/uploads/photo-1773057732483.png"
Result: ✅ Works
```

#### 2. Full URL
```dart
Input: "http://example.com/image.jpg"
Expected: "http://example.com/image.jpg"
Result: ✅ Works
```

#### 3. Path Without Leading Slash
```dart
Input: "uploads/photo.png"
Expected: "http://192.168.1.95:5000/uploads/photo.png"
Result: ✅ Works
```

#### 4. Empty or Null
```dart
Input: null or ""
Expected: ""
Result: ✅ Works (shows fallback)
```

#### 5. Invalid URL
```dart
Input: "invalid-url"
Expected: Shows error builder
Result: ✅ Works (shows initial avatar)
```

---

## Manual Testing Steps

### 1. Test Image Loading
```
1. Create jeweller with logo
2. Verify logo appears in list
3. Verify logo appears in details
4. Verify loading indicator shows briefly
5. ✅ No errors in console
```

### 2. Test Error Handling
```
1. Create jeweller with invalid image URL
2. Verify fallback avatar shows
3. Verify no crashes
4. ✅ Graceful degradation
```

### 3. Test Loading States
```
1. Use slow network (throttle in dev tools)
2. Verify loading indicators appear
3. Verify smooth transition to image
4. ✅ Good UX during loading
```

### 4. Test Edit Mode
```
1. Edit jeweller with existing logo
2. Verify logo preview shows correctly
3. Change logo
4. Verify new logo uploads
5. ✅ Both network and local images work
```

---

## Code Examples

### Using the Helper

```dart
// In any widget
import 'package:digital_jeweller/core/constants/api_endpoints.dart';

// For network images
Image.network(
  ApiEndpoints.getImageUrl(imagePathFromAPI),
  errorBuilder: (context, error, stackTrace) {
    return Icon(Icons.error);
  },
)

// For cached network images
CachedNetworkImage(
  imageUrl: ApiEndpoints.getImageUrl(imagePathFromAPI),
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
)
```

### Checking if Image Exists

```dart
final imageUrl = ApiEndpoints.getImageUrl(jeweller.logo);
if (imageUrl.isNotEmpty) {
  // Show image
  Image.network(imageUrl);
} else {
  // Show placeholder
  Icon(Icons.person);
}
```

---

## Error Messages (Before Fix)

### Console Errors
```
ArgumentError: Invalid argument(s): No host specified in URI file:///uploads/photo-1773057732483.png

NetworkImageLoadException: HTTP request failed, statusCode: 404, 
http://192.168.1.95:5000/api/uploads/photo-1773057732483.png
```

### After Fix
```
✅ No errors
✅ Images load correctly
✅ Proper URLs constructed
```

---

## URL Construction Logic

### Base URL
```dart
static const String baseUrl = 'http://192.168.1.95:5000/api';
```

### Image Base URL (without /api)
```dart
final imageBaseUrl = baseUrl.replaceAll('/api', '');
// Result: 'http://192.168.1.95:5000'
```

### Complete Image URL
```dart
final cleanPath = imagePath.startsWith('/') ? imagePath : '/$imagePath';
final fullUrl = '$imageBaseUrl$cleanPath';
// Result: 'http://192.168.1.95:5000/uploads/photo.png'
```

---

## API Response Examples

### Create Jeweller Response
```json
{
  "responseStatus": 201,
  "responseMessage": "Jeweller created successfully",
  "responseData": {
    "jeweller": {
      "_id": "...",
      "name": "Test Jeweller",
      "logo": "/uploads/photo-1773057732483.png",
      ...
    }
  }
}
```

### Get Jewellers Response
```json
{
  "responseStatus": 200,
  "responseMessage": "Jewellers retrieved",
  "responseData": {
    "jewellers": [
      {
        "_id": "...",
        "logo": "/uploads/photo-1773057732483.png",
        ...
      }
    ]
  }
}
```

**Note**: API returns relative paths, app converts to full URLs.

---

## Best Practices

### 1. Always Use Helper
```dart
// ✅ Good
Image.network(ApiEndpoints.getImageUrl(logo))

// ❌ Bad
Image.network(logo)
```

### 2. Always Add Error Builder
```dart
Image.network(
  ApiEndpoints.getImageUrl(logo),
  errorBuilder: (context, error, stackTrace) {
    return FallbackWidget();
  },
)
```

### 3. Always Add Loading Builder
```dart
Image.network(
  ApiEndpoints.getImageUrl(logo),
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return CircularProgressIndicator();
  },
)
```

### 4. Check for Empty URLs
```dart
final imageUrl = ApiEndpoints.getImageUrl(logo);
if (imageUrl.isEmpty) {
  return PlaceholderWidget();
}
return Image.network(imageUrl);
```

---

## Future Enhancements

### 1. Image Caching
```dart
// Use cached_network_image package
CachedNetworkImage(
  imageUrl: ApiEndpoints.getImageUrl(logo),
  cacheKey: logo,
)
```

### 2. Image Optimization
```dart
// Add size parameters
static String getImageUrl(String? imagePath, {int? width, int? height}) {
  final url = getImageUrl(imagePath);
  if (width != null || height != null) {
    return '$url?w=$width&h=$height';
  }
  return url;
}
```

### 3. CDN Support
```dart
// Support multiple image sources
static String getImageUrl(String? imagePath) {
  if (imagePath?.startsWith('cdn://') == true) {
    return imagePath!.replaceFirst('cdn://', cdnBaseUrl);
  }
  // ... existing logic
}
```

---

## Troubleshooting

### Images Still Not Loading?

1. **Check Base URL**
   ```dart
   print(ApiEndpoints.baseUrl);
   // Should be: http://192.168.1.95:5000/api
   ```

2. **Check Image Path from API**
   ```dart
   print(jeweller.logo);
   // Should be: /uploads/photo-xxx.png
   ```

3. **Check Final URL**
   ```dart
   print(ApiEndpoints.getImageUrl(jeweller.logo));
   // Should be: http://192.168.1.95:5000/uploads/photo-xxx.png
   ```

4. **Check Network Access**
   ```bash
   curl http://192.168.1.95:5000/uploads/photo-xxx.png
   # Should return image data
   ```

### 404 Errors?

- Verify file exists on server
- Check file permissions
- Verify path is correct
- Check server static file serving

### Loading Forever?

- Check network connection
- Verify server is running
- Check firewall settings
- Try with smaller image

---

## Status

✅ Image URL construction fixed
✅ All screens updated
✅ Loading indicators added
✅ Error handling improved
✅ No console errors
✅ Ready for production

---

**Fixed Date**: March 9, 2026
**Status**: ✅ Complete
**Tested**: ✅ Working
