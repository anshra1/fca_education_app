import 'package:equatable/equatable.dart';
import 'package:fca_education_app/core/errors/exception.dart';

abstract class Failure extends Equatable {
  const Failure({
    required this.message,
    required this.statusCode,
  }) : assert(
          statusCode is int || statusCode is String,
          'statusCode must be of type int or String',
        );

  final String message;
  final dynamic statusCode;

  String get errorMessage {
    final showErrorText =
        statusCode is! String || int.tryParse(statusCode as String) != null;
    return '$statusCode ${showErrorText ? 'Error' : ''}: $message';
  }

  @override
  List<Object> get props => [message, statusCode as Object];
}

class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    required super.statusCode,
  });

  CacheFailure.fromException({
    required CacheException cacheException,
  }) : this(
          message: cacheException.message,
          statusCode: cacheException.statusCode,
        );

  @override
  String toString() =>
      'CacheFailure(message: $message, statusCode: $statusCode)';
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    required super.statusCode,
  });

  ServerFailure.fromException({
    required ServerException serverException,
  }) : this(
          message: serverException.message,
          statusCode: serverException.statusCode,
        );
}
