part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {
  const AuthInitialState();
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

class AuthErrorState extends AuthState {
  const AuthErrorState(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

class AuthSignInState extends AuthState {
  const AuthSignInState(this.localUser);
  final LocalUser localUser;

  @override
  List<Object> get props => [localUser];
}

class AuthSignUpState extends AuthState {
  const AuthSignUpState();
}

class ForgotPasswordSentState extends AuthState {
  const ForgotPasswordSentState();
}

class UserUpdateState extends AuthState {
  const UserUpdateState();
}
