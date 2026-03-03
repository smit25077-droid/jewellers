# Master Admin API Test Collection

## Postman/Thunder Client Collection

### Environment Variables
```json
{
  "baseUrl": "http://your-api-url.com/api",
  "token": "your-auth-token-here",
  "jewellerId": ""
}
```

---

## 1. Get All Jewellers

### Request
```
GET {{baseUrl}}/jewellers
```

### Headers
```
Authorization: Bearer {{token}}
Content-Type: application/json
```

### Success Response (200)
```json
{
  "responseStatus": 200,
  "responseMessage": "Jewellers retrieved",
  "responseData": {
    "count": 3,
    "jewellers": [
      {
        "_id": "65abc123def456",
        "name": "Golden Jewellers",
        "address": "123 Main St, Mumbai",
        "phone": "9876543210",
        "email": "golden@example.com",
        "jewellerCode": "GJ001",
        "panNumber": "ABCDE1234F",
        "aadhaarNumber": "123456789012",
        "gstNumber": "27AAAAA0000A1Z5",
        "isActive": true,
        "logo": null
      }
    ]
  }
}
```

### Error Responses

#### 401 Unauthorized
```json
{
  "responseStatus": 401,
  "responseMessage": "Unauthorized. Please login again."
}
```

#### 500 Server Error
```json
{
  "responseStatus": 500,
  "responseMessage": "Internal server error"
}
```

### Test Scripts
```javascript
// Save first jeweller ID for other tests
if (pm.response.code === 200) {
    const response = pm.response.json();
    if (response.responseData.jewellers.length > 0) {
        pm.environment.set("jewellerId", response.responseData.jewellers[0]._id);
    }
}

// Assertions
pm.test("Status code is 200", () => {
    pm.response.to.have.status(200);
});

pm.test("Response has jewellers array", () => {
    const response = pm.response.json();
    pm.expect(response.responseData).to.have.property('jewellers');
    pm.expect(response.responseData.jewellers).to.be.an('array');
});
```

---

## 2. Create Jeweller

### Request
```
POST {{baseUrl}}/jewellers
```

### Headers
```
Authorization: Bearer {{token}}
Content-Type: application/json
```

### Body
```json
{
  "name": "Silver Jewellers",
  "address": "456 Park Avenue, Delhi",
  "phone": "9123456789",
  "email": "silver@example.com",
  "jewellerCode": "SJ002",
  "password": "SecurePass123!",
  "panNumber": "FGHIJ5678K",
  "aadhaarNumber": "987654321098",
  "gstNumber": "07BBBBB1111B2Z6"
}
```

### Success Response (201)
```json
{
  "responseStatus": 201,
  "responseMessage": "Jeweller created successfully",
  "responseData": {
    "jeweller": {
      "_id": "65abc789def012",
      "name": "Silver Jewellers",
      "address": "456 Park Avenue, Delhi",
      "phone": "9123456789",
      "email": "silver@example.com",
      "jewellerCode": "SJ002",
      "panNumber": "FGHIJ5678K",
      "aadhaarNumber": "987654321098",
      "gstNumber": "07BBBBB1111B2Z6",
      "isActive": true,
      "logo": null
    }
  }
}
```

### Error Responses

#### 400 Validation Error
```json
{
  "responseStatus": 400,
  "responseMessage": "Email already exists"
}
```

```json
{
  "responseStatus": 400,
  "responseMessage": "Jeweller code already exists"
}
```

```json
{
  "responseStatus": 400,
  "responseMessage": "Invalid email format"
}
```

### Test Scripts
```javascript
// Save created jeweller ID
if (pm.response.code === 201) {
    const response = pm.response.json();
    pm.environment.set("jewellerId", response.responseData.jeweller._id);
}

// Assertions
pm.test("Status code is 201", () => {
    pm.response.to.have.status(201);
});

pm.test("Jeweller created with correct data", () => {
    const response = pm.response.json();
    const jeweller = response.responseData.jeweller;
    pm.expect(jeweller.name).to.eql("Silver Jewellers");
    pm.expect(jeweller.isActive).to.be.true;
});
```

---

## 3. Toggle Jeweller Status

### Request
```
PUT {{baseUrl}}/jewellers/{{jewellerId}}
```

### Headers
```
Authorization: Bearer {{token}}
Content-Type: application/json
```

### Body (Deactivate)
```json
{
  "isActive": false
}
```

### Body (Activate)
```json
{
  "isActive": true
}
```

### Success Response (200)
```json
{
  "responseStatus": 200,
  "responseMessage": "Jeweller status updated successfully",
  "responseData": {
    "jeweller": {
      "_id": "65abc789def012",
      "name": "Silver Jewellers",
      "isActive": false,
      ...
    }
  }
}
```

### Error Responses

#### 404 Not Found
```json
{
  "responseStatus": 404,
  "responseMessage": "Jeweller not found"
}
```

### Test Scripts
```javascript
pm.test("Status code is 200", () => {
    pm.response.to.have.status(200);
});

pm.test("Status updated correctly", () => {
    const response = pm.response.json();
    const requestBody = JSON.parse(pm.request.body.raw);
    pm.expect(response.responseData.jeweller.isActive).to.eql(requestBody.isActive);
});
```

---

## 4. Delete Jeweller

### Request
```
DELETE {{baseUrl}}/jewellers/{{jewellerId}}
```

### Headers
```
Authorization: Bearer {{token}}
```

### Success Response (200)
```json
{
  "responseStatus": 200,
  "responseMessage": "Jeweller deleted successfully"
}
```

### Error Responses

#### 404 Not Found
```json
{
  "responseStatus": 404,
  "responseMessage": "Jeweller not found"
}
```

#### 400 Cannot Delete
```json
{
  "responseStatus": 400,
  "responseMessage": "Cannot delete jeweller with active customers"
}
```

### Test Scripts
```javascript
pm.test("Status code is 200", () => {
    pm.response.to.have.status(200);
});

pm.test("Success message received", () => {
    const response = pm.response.json();
    pm.expect(response.responseMessage).to.include("deleted");
});
```

---

## Complete Test Flow

### 1. Setup
```javascript
// Set environment variables
pm.environment.set("baseUrl", "http://localhost:3000/api");
pm.environment.set("token", "your-token-here");
```

### 2. Test Sequence
1. **Get All Jewellers** - Verify initial state
2. **Create Jeweller** - Add new jeweller
3. **Get All Jewellers** - Verify jeweller was added
4. **Toggle Status (Deactivate)** - Deactivate jeweller
5. **Get All Jewellers** - Verify status changed
6. **Toggle Status (Activate)** - Reactivate jeweller
7. **Delete Jeweller** - Remove jeweller
8. **Get All Jewellers** - Verify jeweller was deleted

### 3. Automated Test Runner
```javascript
// Collection Pre-request Script
const timestamp = Date.now();
pm.environment.set("timestamp", timestamp);
pm.environment.set("uniqueEmail", `test${timestamp}@example.com`);
pm.environment.set("uniqueCode", `JC${timestamp}`);
```

---

## Error Handling Test Cases

### 1. Invalid Token
```
Authorization: Bearer invalid-token
Expected: 401 Unauthorized
```

### 2. Missing Required Fields
```json
{
  "name": "",
  "email": "test@example.com"
}
Expected: 400 Bad Request
```

### 3. Duplicate Email
```json
{
  "email": "existing@example.com",
  ...
}
Expected: 400 Bad Request - "Email already exists"
```

### 4. Invalid Email Format
```json
{
  "email": "invalid-email",
  ...
}
Expected: 400 Bad Request - "Invalid email format"
```

### 5. Invalid Phone Number
```json
{
  "phone": "123",
  ...
}
Expected: 400 Bad Request - "Invalid phone number"
```

### 6. Non-existent Jeweller ID
```
DELETE /jewellers/invalid-id-123
Expected: 404 Not Found
```

---

## Performance Testing

### Load Test Scenarios

#### 1. Concurrent Reads
- 100 simultaneous GET requests
- Expected: < 500ms response time
- Success rate: > 99%

#### 2. Concurrent Writes
- 10 simultaneous POST requests
- Expected: < 1000ms response time
- No duplicate entries

#### 3. Mixed Operations
- 50 GET, 25 POST, 15 PUT, 10 DELETE
- Expected: All operations complete successfully
- No data corruption

---

## Security Testing

### 1. Authentication
- [ ] Requests without token return 401
- [ ] Expired token returns 401
- [ ] Invalid token returns 401

### 2. Authorization
- [ ] Regular user cannot access master admin endpoints
- [ ] Only master admin can create jewellers
- [ ] Only master admin can delete jewellers

### 3. Input Validation
- [ ] SQL injection attempts blocked
- [ ] XSS attempts sanitized
- [ ] Malformed JSON rejected

### 4. Rate Limiting
- [ ] Too many requests return 429
- [ ] Rate limit headers present

---

## Monitoring & Logging

### Key Metrics to Track
- Response time (avg, p95, p99)
- Error rate
- Success rate
- Request volume
- Database query time

### Log Analysis
- Check for error patterns
- Monitor slow queries
- Track failed authentication attempts
- Review validation failures

---

**Last Updated**: March 2, 2026  
**Status**: Ready for API Testing ✅
