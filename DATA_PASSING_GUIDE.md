# Passing Data Between Screens in GetX

## 📚 Complete Guide

### ✅ How It Works Now

#### 1. **From List Screen (Sending Data)**
**File**: `admin_customer_list_page.dart`

```dart
// When user taps "Update Profile" button
ClassicOutlinedButton(
  text: "Update Profile",
  icon: Icons.edit_outlined,
  onPressed: () {
    // Pass customer object as argument
    Get.toNamed(
      AppRoutes.adminAddUser,
      arguments: customer,  // ← Pass the customer here
    )?.then((value) {
      controller.loadCustomers();  // Refresh list when returning
    });
  },
),
```

#### 2. **Route Configuration (Receiving Data)**
**File**: `app_pages.dart`

```dart
GetPage(
  name: AppRoutes.adminAddUser,
  page: () => CustomerAddUpdatePage(
    customer: Get.arguments,  // ← Receive the customer here
  ),
  binding: AdminCustomerListBinding(),
  transition: Transition.rightToLeft,
  transitionDuration: const Duration(milliseconds: 300),
),
```

#### 3. **Destination Screen (Using Data)**
**File**: `customer_add_update_page.dart`

```dart
class CustomerAddUpdatePage extends StatefulWidget {
  final Customer? customer;  // ← Receives the customer

  const CustomerAddUpdatePage({super.key, this.customer});

  @override
  State<CustomerAddUpdatePage> createState() => _CustomerAddUpdatePageState();
}

class _CustomerAddUpdatePageState extends State<CustomerAddUpdatePage> {
  @override
  void initState() {
    super.initState();
    
    // Use the customer data
    if (widget.customer != null) {
      // Edit mode - pre-fill form with customer data
      controller.nameController.text = widget.customer!.name;
      controller.phoneController.text = widget.customer!.phone;
      controller.emailController.text = widget.customer!.email;
    } else {
      // Add mode - empty form
    }
  }
}
```

---

## 🎯 Complete Data Flow

```
┌──────────────────────┐
│  Customer List       │
│  ┌───────────────┐   │
│  │ Customer Card │   │
│  │  Name: John   │   │
│  │  Phone: 123   │   │
│  │  ┌──────────┐ │   │
│  │  │ UPDATE   │ │   │  ← User clicks
│  │  └──────────┘ │   │
│  └───────────────┘   │
└──────────────────────┘
          │
          │ Get.toNamed(AppRoutes.adminAddUser, arguments: customer)
          ↓
┌──────────────────────┐
│  Route (app_pages)   │
│  Get.arguments       │  ← Receives customer
└──────────────────────┘
          │
          ↓
┌──────────────────────┐
│  Add/Update Screen   │
│  widget.customer     │  ← Uses customer data
│  ┌────────────────┐  │
│  │ Name: John     │  │  ← Pre-filled
│  │ Phone: 123     │  │  ← Pre-filled
│  │ Email: @...    │  │  ← Pre-filled
│  └────────────────┘  │
└──────────────────────┘
```

---

## 💡 Usage Examples

### Example 1: Add New Customer (No Data)
```dart
// From anywhere in the app
Get.toNamed(AppRoutes.adminAddUser);  // No arguments = Add mode
```

### Example 2: Edit Customer (With Data)
```dart
// From customer list
Get.toNamed(
  AppRoutes.adminAddUser,
  arguments: selectedCustomer,  // Pass customer object
);
```

### Example 3: With Callback (Refresh on Return)
```dart
// From customer list
Get.toNamed(
  AppRoutes.adminAddUser,
  arguments: customer,
)?.then((result) {
  // This runs when user returns from Add/Update screen
  controller.loadCustomers();  // Refresh the list
  
  if (result != null) {
    // You can also return data from Add/Update screen
    print('Customer updated: $result');
  }
});
```

---

## 🔄 Two-Way Data Passing

### Sending Data Back from Add/Update Screen

```dart
// In customer_add_update_page.dart

// After successful save/update
Get.back(result: updatedCustomer);  // ← Send data back

// Or just close
Get.back();
```

### Receiving Return Data in List Screen

```dart
// In admin_customer_list_page.dart

Get.toNamed(
  AppRoutes.adminAddUser,
  arguments: customer,
)?.then((returnedData) {
  if (returnedData != null) {
    print('Returned: $returnedData');
    // Do something with returned data
  }
  controller.loadCustomers();
});
```

---

## 📋 Multiple Arguments

If you need to pass multiple values:

### Option 1: Pass a Map
```dart
// From list screen
Get.toNamed(
  AppRoutes.adminAddUser,
  arguments: {
    'customer': customer,
    'mode': 'edit',
    'source': 'customer_list',
  },
);

// In route
page: () => CustomerAddUpdatePage(
  customer: (Get.arguments as Map)['customer'],
),

// Or in CustomerAddUpdatePage
final args = Get.arguments as Map;
final customer = args['customer'];
final mode = args['mode'];
```

### Option 2: Create a Parameter Class
```dart
// Create a class
class CustomerPageParams {
  final Customer? customer;
  final String mode;
  
  CustomerPageParams({this.customer, this.mode = 'add'});
}

// From list screen
Get.toNamed(
  AppRoutes.adminAddUser,
  arguments: CustomerPageParams(
    customer: customer,
    mode: 'edit',
  ),
);

// In route
page: () => CustomerAddUpdatePage(
  customer: (Get.arguments as CustomerPageParams).customer,
),
```

---

## 🎨 Your Current Implementation

### ✅ What's Working:

1. **List Screen** → Passes `customer` object via `arguments`
2. **Route** → Receives via `Get.arguments` 
3. **Add/Update Screen** → Uses `widget.customer` to:
   - Show edit mode UI if customer exists
   - Pre-fill form fields
   - Show delete button

### 🔍 Detection Logic:

```dart
// In customer_add_update_page.dart

if (widget.customer != null) {
  // EDIT MODE
  // - Show customer header with avatar
  // - Pre-fill form fields
  // - Show delete button
  // - Button text: "Update Customer"
} else {
  // ADD MODE
  // - Hide customer header
  // - Empty form fields
  // - No delete button
  // - Button text: "Create Customer"
  // - Show password field
}
```

---

## 🚀 Benefits of This Approach

✅ **Type-Safe**: Passing Customer object directly  
✅ **Clean Code**: Single screen for add & edit  
✅ **Reusable**: Can be called from anywhere  
✅ **Automatic Refresh**: List refreshes when returning  
✅ **GetX Native**: Uses built-in GetX routing  

---

## 🐛 Common Issues & Solutions

### Issue 1: `Get.arguments` is null
**Solution**: Make sure you're passing arguments in `Get.toNamed()`

### Issue 2: Type casting error
**Solution**: Use safe casting `Get.arguments as Customer?`

### Issue 3: Screen doesn't update
**Solution**: Remove `const` from `CustomerAddUpdatePage()` in route

### Issue 4: Data not persisting
**Solution**: Make sure to save in controller before calling `Get.back()`

---

**Your implementation is now correct! 🎉**

The customer data flows from list → route → add/update screen seamlessly!
