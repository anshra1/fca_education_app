import 'package:dartz/dartz.dart';
import 'package:fca_education_app/core/enum/user_data.dart';
import 'package:fca_education_app/core/errors/exception.dart';
import 'package:fca_education_app/core/errors/failure.dart';
import 'package:fca_education_app/core/utils/typedefs.dart';
import 'package:fca_education_app/src/auth/datasources/datasources/auth_remote_src.dart';
import 'package:fca_education_app/src/auth/domain/auth_repo.dart/atuh_repo.dart';
import 'package:fca_education_app/src/auth/domain/entites/local_user.dart';

class AuthRepoImpl extends AuthRepo {
  AuthRepoImpl({required AuthRemotedataSources authRemotedataSources})
      : _authRemotedataSources = authRemotedataSources;

  final AuthRemotedataSources _authRemotedataSources;

  @override
  ResultFuture<void> forgotPassword({
    required String email,
  }) async {
    try {
      await _authRemotedataSources.forgotPassword(email: email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(serverException: e));
    }
  }

  @override
  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final localUser = await _authRemotedataSources.signIn(
        email: email,
        password: password,
      );
      return Right(localUser);
    } on ServerException catch (e) {
      return Left(
        ServerFailure.fromException(serverException: e),
      );
    }
  }

  @override
  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      await _authRemotedataSources.signUp(
        email: email,
        fullName: fullName,
        password: password,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure.fromException(serverException: e),
      );
    }
  }

  @override
  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  }) async {
    try {
      await _authRemotedataSources.updateUser(
        action: action,
        userData: userData,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure.fromException(serverException: e),
      );
    }
  }
}
