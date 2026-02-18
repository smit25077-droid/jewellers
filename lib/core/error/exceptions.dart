/// Server Exception - API errors
class ServerException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ServerException({required this.message, this.statusCode, this.data});

  @override
  String toString() => 'ServerException: $message (Status: $statusCode)';
}

/// Cache Exception - Local storage errors
class CacheException implements Exception {
  final String message;

  CacheException({this.message = 'Cache error occurred'});

  @override
  String toString() => 'CacheException: $message';
}

/// Network Exception - Connectivity errors
class NetworkException implements Exception {
  final String message;

  NetworkException({this.message = 'No internet connection'});

  @override
  String toString() => 'NetworkException: $message';
}

/// Validation Exception - Input validation errors
class ValidationException implements Exception {
  final String message;
  final Map<String, String>? errors;

  ValidationException({required this.message, this.errors});

  @override
  String toString() => 'ValidationException: $message';
}

/// Authentication Exception - Auth related errors
class AuthenticationException implements Exception {
  final String message;

  AuthenticationException({this.message = 'Authentication failed'});

  @override
  String toString() => 'AuthenticationException: $message';
}

/// Authorization Exception - Permission errors
class AuthorizationException implements Exception {
  final String message;

  AuthorizationException({this.message = 'Access denied'});

  @override
  String toString() => 'AuthorizationException: $message';
}
