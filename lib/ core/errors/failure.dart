import 'package:equatable/equatable.dart';
import 'package:fca_education_app/%20core/errors/exception.dart';

abstract class Failure extends Equatable {
  Failure({
    required this.message,
    required this.statusCode,
  }) : assert(
          statusCode.runtimeType == int || statusCode.runtimeType == String,
          'statusCode must be of type int or String',
        );

  final String message;
  final dynamic statusCode;

  @override
  List<Object> get props => [message, statusCode as Object];
}

class CacheFailure extends Failure {
   CacheFailure({
    required super.message,
    required super.statusCode,
  });
}

class ServerFailure extends Failure {
   ServerFailure({
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
