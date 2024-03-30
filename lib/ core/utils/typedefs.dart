import 'package:dartz/dartz.dart';
import 'package:fca_education_app/%20core/errors/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef DataMap = Map<String, dynamic>;
