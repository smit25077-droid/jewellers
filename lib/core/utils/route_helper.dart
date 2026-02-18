// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// /// Route Navigation Helper
// class RouteHelper {
//   /// Navigate to a named route
//   static Future<T?>? toNamed<T>(
//     String routeName, {
//     dynamic arguments,
//     Map<String, String>? parameters,
//   }) {
//     return Get.toNamed<T>(
//       routeName,
//       arguments: arguments,
//       parameters: parameters,
//     );
//   }
//
//   /// Navigate to a named route and remove all previous routes
//   static Future<T?>? offAllNamed<T>(
//     String routeName, {
//     dynamic arguments,
//     Map<String, String>? parameters,
//   }) {
//     return Get.offAllNamed<T>(
//       routeName,
//       arguments: arguments,
//       parameters: parameters,
//     );
//   }
//
//   /// Navigate to a named route and remove the previous route
//   static Future<T?>? offNamed<T>(
//     String routeName, {
//     dynamic arguments,
//     Map<String, String>? parameters,
//   }) {
//     return Get.offNamed<T>(
//       routeName,
//       arguments: arguments,
//       parameters: parameters,
//     );
//   }
//
//   /// Navigate to a named route and remove routes until predicate
//   static Future<T?>? offNamedUntil<T>(
//     String routeName,
//     bool Function(GetPage) predicate, {
//     dynamic arguments,
//     Map<String, String>? parameters,
//   }) {
//     return Get.offNamedUntil<T>(
//       routeName,
//       predicate,
//       arguments: arguments,
//       parameters: parameters,
//     );
//   }
//
//   /// Go back to previous route
//   static void back<T>({T? result}) {
//     Get.back<T>(result: result);
//   }
//
//   /// Check if can go back
//   static bool canGoBack() {
//     return Navigator.canPop(Get.context!);
//   }
//
//   /// Navigate to a route with transition
//   static Future<T?>? to<T>(
//     dynamic page, {
//     dynamic arguments,
//     Transition? transition,
//   }) {
//     return Get.to<T>(
//       page,
//       arguments: arguments,
//       transition: transition,
//     );
//   }
//
//   /// Replace current route
//   static Future<T?>? off<T>(
//     dynamic page, {
//     dynamic arguments,
//     Transition? transition,
//   }) {
//     return Get.off<T>(
//       page,
//       arguments: arguments,
//       transition: transition,
//     );
//   }
//
//   /// Remove all routes and navigate to new route
//   static Future<T?>? offAll<T>(
//     dynamic page, {
//     dynamic arguments,
//     Transition? transition,
//   }) {
//     return Get.offAll<T>(
//       page,
//       arguments: arguments,
//       transition: transition,
//     );
//   }
// }
