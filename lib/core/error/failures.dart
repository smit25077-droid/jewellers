/// Base Failure class
abstract class Failure {
  final String message;

  Failure({required this.message});

  @override
  String toString() => message;
}

/// Server Failure - API errors
class ServerFailure extends Failure {
  final int? statusCode;
  final dynamic data;

  ServerFailure({required String message, this.statusCode, this.data})
    : super(message: message);

  @override
  String toString() => 'ServerFailure: $message (Status: $statusCode)';
}

/// Cache Failure - Local storage errors
class CacheFailure extends Failure {
  CacheFailure({required String message}) : super(message: message);

  @override
  String toString() => 'CacheFailure: $message';
}

/// Network Failure - Connectivity errors
class NetworkFailure extends Failure {
  NetworkFailure({required String message}) : super(message: message);

  @override
  String toString() => 'NetworkFailure: $message';
}

/// Validation Failure - Input validation errors
class ValidationFailure extends Failure {
  final Map<String, String>? errors;

  ValidationFailure({required String message, this.errors})
    : super(message: message);

  @override
  String toString() => 'ValidationFailure: $message';
}

/// Authentication Failure - Auth related errors
class AuthenticationFailure extends Failure {
  AuthenticationFailure({required String message}) : super(message: message);

  @override
  String toString() => 'AuthenticationFailure: $message';
}

/// Authorization Failure - Permission errors
class AuthorizationFailure extends Failure {
  AuthorizationFailure({required String message}) : super(message: message);

  @override
  String toString() => 'AuthorizationFailure: $message';
}
