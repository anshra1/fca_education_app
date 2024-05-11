import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fca_education_app/core/enum/user_data.dart';
import 'package:fca_education_app/src/auth/domain/entites/local_user.dart';
import 'package:fca_education_app/src/auth/domain/usecases/forgot_password.dart';
import 'package:fca_education_app/src/auth/domain/usecases/sign_in.dart';
import 'package:fca_education_app/src/auth/domain/usecases/sign_up.dart';
import 'package:fca_education_app/src/auth/domain/usecases/update_user.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignIn signIn,
    required SignUp signUp,
    required ForgotPassword forgotPassword,
    required UpdateUser updateUser,
  })  : _signIn = signIn,
        _signUp = signUp,
        _forgotPassword = forgotPassword,
        _updateUser = updateUser,
        super(const AuthInitialState()) {
    on<AuthEvent>((event, emit) {
      emit(const AuthLoadingState());
    });

    on<SignInEvent>(_signInHandler);
    on<SignUpEvent>(_signUpEventHandler);
    on<ForgotPasswordEvent>(_forgotPasswordHandler);
    on<UpdateUserEvent>(_updateUserHandler);
  }

  final SignIn _signIn;
  final SignUp _signUp;
  final ForgotPassword _forgotPassword;
  final UpdateUser _updateUser;

  Future<void> _signInHandler(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signIn(
      params: SignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthErrorState(failure.errorMessage)),
      (user) => emit(AuthSignInState(user)),
    );
  }

  Future<void> _signUpEventHandler(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signUp(
      params: SignUpParams(
        email: event.email,
        password: event.password,
        fullName: event.name,
      ),
    );

    result.fold(
      (failure) => emit(AuthErrorState(failure.errorMessage)),
      (_) => emit(const AuthSignUpState()),
    );
  }

  Future<void> _forgotPasswordHandler(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _forgotPassword(params: event.email);

    result.fold(
      (failure) => emit(AuthErrorState(failure.errorMessage)),
      (_) => emit(const ForgotPasswordSentState()),
    );
  }

  Future<void> _updateUserHandler(
    UpdateUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _updateUser(
      params: UpdateUserParams(
        action: event.action,
        userData: event.userData,
      ),
    );

    result.fold(
      (failure) {
      
        emit(AuthErrorState(failure.errorMessage));
      },
      (_) => emit(const UserUpdateState()),
    );
  }
}
