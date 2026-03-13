# API Integration Quick Reference

## Base URL
```
http://192.168.1.95:5000/api
```

## Authentication
All requests require Bearer token in Authorization header:
```
Authorization: Bearer {your_token_here}
```

---

## 1. Create Jeweller

### Endpoint
```
POST /jewellers
```

### Content-Type
```
multipart/form-data
```

### Request Body (Form Data)
```
name: "New Patel Jeweller"
address: "123 Luxury Lane"
phone: "1234567898"
email: "patelcontact@diamondhouse.com"
logo: [file]
password: "smit8618"
jewellerCode: "JW2"
panNumber: "ABCDE1234F"
aadhaarNumber: "123412341234"
gstNumber: "22ABCDE1234F1Z5"
```

### cURL Example
```bash
curl --location 'http://192.168.1.95:5000/api/jewellers' \
--header 'Authorization: Bearer YOUR_TOKEN' \
--form 'name="New Patel Jeweller"' \
--form 'address="123 Luxury Lane"' \
--form 'phone="1234567898"' \
--form 'email="patelcontact@diamondhouse.com"' \
--form 'logo=@"/path/to/file"' \
--form 'password="smit8618"' \
--form 'jewellerCode="JW2"' \
--form 'panNumber="ABCDE1234F"' \
--form 'aadhaarNumber="123412341234"' \
--form 'gstNumber="22ABCDE1234F1Z5"'
```

### Success Response (201)
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

### Error Responses

#### 400 - Validation Error
```json
{
  "responseStatus": 400,
  "responseMessage": "Email already exists"
}
```

#### 400 - Duplicate Code
```json
{
  "responseStatus": 400,
  "responseMessage": "Jeweller code already exists"
}
```

#### 401 - Unauthorized
```json
{
  "responseStatus": 401,
  "responseMessage": "Unauthorized. Please login again."
}
```

---

## 2. Update Jeweller

### Endpoint
```
PUT /jewellers/{JEWELLER_ID}
```

### Content-Type
```
multipart/form-data
```

### Request Body (Form Data)
```
name: "Diamond House Updated"
phone: "9870000000"
logo: [file]
```

**Note**: Only include fields you want to update. All fields are optional.

### cURL Example
```bash
curl --location --request PUT 'http://192.168.1.95:5000/api/jewellers/JEWELLER_ID' \
--header 'Authorization: Bearer YOUR_TOKEN' \
--form 'name="Diamond House Updated"' \
--form 'phone="9870000000"' \
--form 'logo=@"/path/to/file"'
```

### Success Response (200)
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

### Error Responses

#### 404 - Not Found
```json
{
  "responseStatus": 404,
  "responseMessage": "Jeweller not found"
}
```

#### 400 - Validation Error
```json
{
  "responseStatus": 400,
  "responseMessage": "Invalid phone number format"
}
```

---

## 3. Get All Jewellers

### Endpoint
```
GET /jewellers
```

### cURL Example
```bash
curl --location 'http://192.168.1.95:5000/api/jewellers' \
--header 'Authorization: Bearer YOUR_TOKEN'
```

### Success Response (200)
```json
{
  "responseStatus": 200,
  "responseMessage": "Jewellers retrieved successfully",
  "responseData": {
    "count": 3,
    "jewellers": [
      {
        "_id": "65abc123def456",
        "name": "Golden Jewellers",
        "address": "123 Main St",
        "phone": "9876543210",
        "email": "golden@example.com",
        "logo": "https://example.com/uploads/logo1.jpg",
        "jewellerCode": "GJ001",
        "panNumber": "ABCDE1234F",
        "aadhaarNumber": "123456789012",
        "gstNumber": "27AAAAA0000A1Z5",
        "isActive": true
      },
      ...
    ]
  }
}
```

---

## 4. Delete Jeweller

### Endpoint
```
DELETE /jewellers/{JEWELLER_ID}
```

### cURL Example
```bash
curl --location --request DELETE 'http://192.168.1.95:5000/api/jewellers/JEWELLER_ID' \
--header 'Authorization: Bearer YOUR_TOKEN'
```

### Success Response (200)
```json
{
  "responseStatus": 200,
  "responseMessage": "Jeweller deleted successfully"
}
```

### Error Responses

#### 404 - Not Found
```json
{
  "responseStatus": 404,
  "responseMessage": "Jeweller not found"
}
```

#### 400 - Cannot Delete
```json
{
  "responseStatus": 400,
  "responseMessage": "Cannot delete jeweller with active customers"
}
```

---

## 5. Toggle Jeweller Status

### Endpoint
```
PUT /jewellers/{JEWELLER_ID}
```

### Content-Type
```
application/json
```

### Request Body
```json
{
  "isActive": false
}
```

### cURL Example
```bash
curl --location --request PUT 'http://192.168.1.95:5000/api/jewellers/JEWELLER_ID' \
--header 'Authorization: Bearer YOUR_TOKEN' \
--header 'Content-Type: application/json' \
--data '{
  "isActive": false
}'
```

### Success Response (200)
```json
{
  "responseStatus": 200,
  "responseMessage": "Jeweller status updated successfully",
  "responseData": {
    "jeweller": {
      "_id": "65abc123def456",
      "name": "Golden Jewellers",
      "isActive": false,
      ...
    }
  }
}
```

---

## Error Handling in App

### Network Errors
```dart
// Connection timeout
'Connection timeout. Please check your internet connection.'

// No internet
'No internet connection'

// Server error
'Server error: 500'
```

### Validation Errors
```dart
// Empty name
'Please enter Jeweller Name'

// Invalid email
'Please enter a valid email'

// Invalid phone
'Mobile number must be 10 digits'

// Short password
'Password must be at least 6 characters'
```

### Server Errors
```dart
// Extracted from response
response.data['responseMessage'] ?? 'An error occurred'
```

---

## Testing with Postman

### 1. Setup Environment
```
baseUrl: http://192.168.1.95:5000/api
token: your_auth_token_here
jewellerId: (will be set after create)
```

### 2. Test Sequence
1. **Login** → Get token
2. **Create Jeweller** → Save jewellerId
3. **Get All Jewellers** → Verify creation
4. **Update Jeweller** → Modify fields
5. **Toggle Status** → Deactivate
6. **Get All Jewellers** → Verify changes
7. **Delete Jeweller** → Remove
8. **Get All Jewellers** → Verify deletion

### 3. Pre-request Script (Generate Unique Data)
```javascript
const timestamp = Date.now();
pm.environment.set("timestamp", timestamp);
pm.environment.set("uniqueEmail", `test${timestamp}@example.com`);
pm.environment.set("uniqueCode", `JC${timestamp}`);
```

### 4. Test Script (Save Response Data)
```javascript
if (pm.response.code === 201) {
    const response = pm.response.json();
    pm.environment.set("jewellerId", response.responseData.jeweller._id);
}

pm.test("Status code is 201", () => {
    pm.response.to.have.status(201);
});

pm.test("Jeweller created successfully", () => {
    const response = pm.response.json();
    pm.expect(response.responseMessage).to.include("created");
});
```

---

## Implementation in Flutter

### Service Layer
```dart
Future<Jeweller> createJeweller(Jeweller jeweller) async {
  dynamic data;
  
  if (jeweller.logo != null && !jeweller.logo!.startsWith('http')) {
    // Multipart form data
    data = FormData.fromMap({
      ...model.toJson(),
      'logo': await MultipartFile.fromFile(
        jeweller.logo!,
        filename: jeweller.logo!.split('/').last,
      ),
    });
  } else {
    // Regular JSON
    data = model.toJson();
  }

  final response = await dioClient.post('/jewellers', data: data);
  
  if (response.statusCode == 201) {
    return JewellerModel.fromJson(response.data['responseData']['jeweller']);
  }
  
  throw DioException(...);
}
```

### Controller Layer
```dart
Future<void> addJeweller() async {
  try {
    isCreatingJeweller.value = true;
    
    final newJeweller = Jeweller(
      // ... fields
      logo: selectedLogoPath.value,
    );
    
    final created = await createJewellerUseCase.call(newJeweller);
    jewellers.add(created);
    
    Get.back();
    showSuccess('Jeweller added successfully');
    await loadJewellers(); // Auto-refresh
    
  } on DioException catch (e) {
    showError(_extractErrorMessage(e));
  } finally {
    isCreatingJeweller.value = false;
  }
}
```

---

## Common Issues & Solutions

### Issue: Logo not uploading
**Solution**: Ensure file path is correct and file exists
```dart
if (jeweller.logo != null && File(jeweller.logo!).existsSync()) {
  // Upload logo
}
```

### Issue: 401 Unauthorized
**Solution**: Check token is valid and not expired
```dart
final token = storage.read('token');
if (token == null || token.isEmpty) {
  // Redirect to login
}
```

### Issue: 400 Validation Error
**Solution**: Check all required fields are provided
```dart
if (!(formKey.currentState?.validate() ?? false)) {
  showError('Please fill all required fields');
  return;
}
```

### Issue: Network timeout
**Solution**: Increase timeout or check network connection
```dart
dio.options.connectTimeout = Duration(seconds: 30);
dio.options.receiveTimeout = Duration(seconds: 30);
```

---

**Last Updated**: March 9, 2026
**API Version**: 1.0
**Status**: ✅ Production Ready
