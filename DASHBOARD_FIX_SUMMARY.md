# Dashboard & Navigation Fixes

## Issues Fixed

### 1. CustomScrollView Sliver Error in JewellerDashboardPage
**Problem:** Mixing regular widgets (Padding, Column) directly in CustomScrollView's slivers list.

**Solution:** Wrapped all non-sliver widgets in `SliverToBoxAdapter` and used `SliverPadding` for padding around slivers.

**Changes:**
- Wrapped header section in `SliverToBoxAdapter`
- Wrapped banner in `SliverToBoxAdapter`
- Wrapped section headers in `SliverToBoxAdapter`
- Used `SliverPadding` to add padding around `SliverGrid` and `SliverList`

### 2. Duplicate GlobalKey Error
**Problem:** Two `AdminDashboard` classes in different locations using identical GlobalKey values:
- `lib/features/admin/presentation/pages/admin_dashboard.dart`
- `lib/features/admin/presentation/dashboard/pages/admin_dashboard.dart`

Both used the same keys:
- `ValueKey('admin_home')`
- `ValueKey('admin_customers')`
- `ValueKey('admin_schemes')`
- `ValueKey('admin_profile')`
- `ValueKey('admin_dashboard_stack')`

**Solution:** Made keys unique in the first file by adding `_v2` suffix:
- `ValueKey('admin_home_v2')`
- `ValueKey('admin_customers_v2')`
- `ValueKey('admin_schemes_v2')`
- `ValueKey('admin_profile_v2')`
- `ValueKey('admin_dashboard_stack_v2')`

### 3. IndexedStack Without Children
**Problem:** The `IndexedStack` in `lib/features/admin/presentation/pages/admin_dashboard.dart` had its children commented out.

**Solution:** Uncommented the `children: _screens` parameter.

### 4. Incorrect Bottom Navigation Behavior
**Problem:** Bottom navigation was calling `Get.toNamed()` on tap, which would navigate to new routes instead of switching tabs in the IndexedStack.

**Solution:** Changed to simple state update: `onTap: (index) => setState(() => _selectedIndex = index)`

## Files Modified

1. `lib/features/admin/presentation/dashboard/jeweller_dashboard_page.dart`
   - Fixed CustomScrollView sliver structure
   - Removed unused import

2. `lib/features/admin/presentation/pages/admin_dashboard.dart`
   - Made GlobalKeys unique
   - Fixed IndexedStack children
   - Fixed bottom navigation behavior
   - Removed unused import

## CustomScrollView Best Practices

When using `CustomScrollView`, remember:

✅ **Correct:**
```dart
CustomScrollView(
  slivers: [
    SliverToBoxAdapter(
      child: Padding(...), // Regular widget wrapped
    ),
    SliverPadding(
      padding: EdgeInsets.all(16),
      sliver: SliverList(...), // Sliver with padding
    ),
    SliverGrid(...), // Direct sliver
  ],
)
```

❌ **Incorrect:**
```dart
CustomScrollView(
  slivers: [
    Padding(...), // ❌ Not a sliver!
    Column(...),  // ❌ Not a sliver!
    SliverList(...),
  ],
)
```

## GlobalKey Best Practices

1. **Always use unique keys** across your entire widget tree
2. **Use descriptive names** that indicate what the key is for
3. **Add version suffixes** if you have similar widgets in different places
4. **Avoid hardcoded keys** in reusable widgets - use parameters instead

## IndexedStack Best Practices

1. **Always provide children** - empty IndexedStack will cause errors
2. **Use unique keys** for each child with `KeyedSubtree`
3. **Don't navigate on tab change** - just update the index
4. **Keep state alive** - IndexedStack preserves state of all children

## Result

All dashboard and navigation errors are now fixed. The app should run without:
- CustomScrollView assertion errors
- Duplicate GlobalKey errors
- IndexedStack errors
- Navigation issues
