import 'package:flutter/cupertino.dart';

import '../error/failures.dart';
import '../error/exceptions.dart';

/// Base Repository class for all repositories
/// Provides common error handling
abstract class BaseRepository {
  /// Execute a function and handle errors
  /// Throws Failure objects for clean error handling
  Future<T> execute<T>(Future<T> Function() function) async {
    try {
      return await function();
    } on ServerException catch (e) {
      debugPrint('❌ BaseRepository: ServerException - ${e.message}');
      throw ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
        data: e.data,
      );
    } on NetworkException catch (e) {
      debugPrint('❌ BaseRepository: NetworkException - ${e.message}');
      throw NetworkFailure(message: e.message);
    } on CacheException catch (e) {
      debugPrint('❌ BaseRepository: CacheException - ${e.message}');
      throw CacheFailure(message: e.message);
    } on ValidationException catch (e) {
      debugPrint('❌ BaseRepository: ValidationException - ${e.message}');
      throw ValidationFailure(message: e.message, errors: e.errors);
    } on AuthenticationException catch (e) {
      debugPrint('❌ BaseRepository: AuthenticationException - ${e.message}');
      throw AuthenticationFailure(message: e.message);
    } on AuthorizationException catch (e) {
      debugPrint('❌ BaseRepository: AuthorizationException - ${e.message}');
      throw AuthorizationFailure(message: e.message);
    } catch (e, stackTrace) {
      debugPrint('❌ BaseRepository: Unexpected exception type: ${e.runtimeType}');
      debugPrint('❌ BaseRepository: Exception details: $e');
      debugPrint('❌ BaseRepository: Stack trace: $stackTrace');
      throw ServerFailure(message: 'Unexpected error: $e');
    }
  }

  /// Execute a function without error conversion (for simple cases)
  /// Throws exceptions directly that should be caught by controllers
  Future<T> executeSimple<T>(Future<T> Function() function) async {
    try {
      return await function();
    } catch (e) {
      rethrow;
    }
  }
}
