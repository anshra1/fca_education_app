import 'package:fca_education_app/%20core/enum/user_data.dart';
import 'package:fca_education_app/%20core/utils/typedefs.dart';
import 'package:fca_education_app/src/auth/domain/entites/local_user.dart';

abstract class AuthRepo {
  const AuthRepo();

  ResultFuture<void> forgotPassword({
    required String email,
  });

  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });
}
