import 'package:equatable/equatable.dart';
import 'package:fca_education_app/core/usecases/usecases.dart';
import 'package:fca_education_app/core/utils/typedefs.dart';
import 'package:fca_education_app/src/auth/domain/auth_repo.dart/atuh_repo.dart';

class SignUp extends UseCaseWithParams<void, SignUpParams> {
  SignUp(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<void> call({required SignUpParams params}) {
    return _authRepo.signUp(
        email: params.email,
        password: params.password,
        fullName: params.fullName,);
  }
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.email,
    required this.password,
    required this.fullName,
  });

  const SignUpParams.empty()
      : this(
          email: '',
          password: '',
          fullName: '',
        );

  final String email;
  final String password;
  final String fullName; // Added for sign up

  @override
  List<Object?> get props => [email, password, fullName];
}
