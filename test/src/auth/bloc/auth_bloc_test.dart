import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fca_education_app/core/errors/failure.dart';
import 'package:fca_education_app/src/auth/domain/entites/local_user.dart';
import 'package:fca_education_app/src/auth/domain/usecases/forgot_password.dart';
import 'package:fca_education_app/src/auth/domain/usecases/sign_in.dart';
import 'package:fca_education_app/src/auth/domain/usecases/sign_up.dart';
import 'package:fca_education_app/src/auth/domain/usecases/update_user.dart';
import 'package:fca_education_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSignIn extends Mock implements SignIn {}

class MockSignUp extends Mock implements SignUp {}

class MockForgotPassword extends Mock implements ForgotPassword {}

class MockUpdateUser extends Mock implements UpdateUser {}

void main() {
  late SignIn signIn;
  late SignUp signUp;
  late ForgotPassword forgotPassword;
  late UpdateUser updateUser;
  late AuthBloc authBloc;

  const tSignUpParams = SignUpParams.empty();
  const tUpdateUserParams = UpdateUserParams.empty();
  const tSingInParams = SignInParams.empty();
  const tServerFailure = ServerFailure(
    message: 'user-not-found',
    statusCode: 'there is no user',
  );

  setUp(
    () {
      signIn = MockSignIn();
      signUp = MockSignUp();
      forgotPassword = MockForgotPassword();
      updateUser = MockUpdateUser();
      authBloc = AuthBloc(
        signIn: signIn,
        signUp: signUp,
        forgotPassword: forgotPassword,
        updateUser: updateUser,
      );
    },
  );

  setUpAll(
    () {
      registerFallbackValue(tSingInParams);
      registerFallbackValue(tSignUpParams);
      registerFallbackValue(tUpdateUserParams);
    },
  );

  tearDown(() {
    authBloc.close();
  });

  test(
    'intialize should be authIntial',
    () {
      expect(authBloc.state, const AuthInitialState());
    },
  );
  group(
    'signInEvent',
    () {
      const tUser = LocalUser.empty();
      blocTest<AuthBloc, AuthState>(
        'should emit AuthLoading, AuthSignIn, when singIn Sucesss',
        build: () {
          when(() => signIn(params: tSingInParams))
              .thenAnswer((_) async => const Right(tUser));

          return authBloc;
        },
        act: (bloc) => bloc.add(
          SignInEvent(
            email: tSingInParams.email,
            password: tSingInParams.password,
          ),
        ),
        expect: () => [
          const AuthLoadingState(),
          const AuthSignInState(tUser),
        ],
        verify: (_) {
          verify(() => signIn(params: tSingInParams)).called(1);
          verifyNoMoreInteractions(signIn);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'should emit AuthLoading, AuthError, when singIn failed',
        build: () {
          when(() => signIn(params: tSingInParams))
              .thenAnswer((_) async => const Left(tServerFailure));

          return authBloc;
        },
        act: (bloc) => bloc.add(
          SignInEvent(
            email: tSingInParams.email,
            password: tSingInParams.password,
          ),
        ),
        expect: () => [
          const AuthLoadingState(),
          AuthErrorState(tServerFailure.errorMessage),
        ],
        verify: (_) {
          verify(() => signIn(params: tSingInParams)).called(1);
          verifyNoMoreInteractions(signIn);
        },
      );
    },
  );

  group(
    'signUpEvent',
    () {
      blocTest<AuthBloc, AuthState>(
        'should emit AuthLoading, AuthSignUpState, when signUp Sucesss',
        build: () {
          when(() => signUp(params: tSignUpParams))
              .thenAnswer((_) async => const Right(null));

          return authBloc;
        },
        act: (bloc) => bloc.add(
          SignUpEvent(
            email: tSignUpParams.email,
            password: tSignUpParams.password,
            name: tSignUpParams.fullName,
          ),
        ),
        expect: () => [
          const AuthLoadingState(),
          const AuthSignUpState(),
        ],
        verify: (_) {
          verify(() => signUp(params: tSignUpParams)).called(1);
          verifyNoMoreInteractions(signUp);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'should emit AuthLoading, AuthError, when signUp failed',
        build: () {
          when(() => signUp(params: tSignUpParams))
              .thenAnswer((_) async => const Left(tServerFailure));

          return authBloc;
        },
        act: (bloc) => bloc.add(
          SignUpEvent(
            email: tSignUpParams.email,
            password: tSignUpParams.password,
            name: tSignUpParams.fullName,
          ),
        ),
        expect: () => [
          const AuthLoadingState(),
          AuthErrorState(tServerFailure.errorMessage),
        ],
        verify: (_) {
          verify(() => signUp(params: tSignUpParams)).called(1);
          verifyNoMoreInteractions(signUp);
        },
      );
    },
  );

  group(
    ' forgot password',
    () {
      blocTest<AuthBloc, AuthState>(
        // ignore: lines_longer_than_80_chars
        'should return AuthLoadingState,ForgotPasswordSentState when forgotPasswordSent',
        build: () {
          when(() => forgotPassword(params: 'email'))
              .thenAnswer((_) async => const Right(null));
          return authBloc;
        },
        act: (bloc) => bloc.add(const ForgotPasswordEvent(email: 'email')),
        expect: () => [
          const AuthLoadingState(),
          const ForgotPasswordSentState(),
        ],
        verify: (_) {
          verify(() => forgotPassword(params: 'email')).called(1);
          verifyNoMoreInteractions(forgotPassword);
        },
      );

      blocTest<AuthBloc, AuthState>(
        // ignore: lines_longer_than_80_chars
        'should return AuthLoadingState,AuthErrorStat when forgotPasswordSent failed',
        build: () {
          when(() => forgotPassword(params: 'email'))
              .thenAnswer((_) async => const Left(tServerFailure));
          return authBloc;
        },
        act: (bloc) => bloc.add(const ForgotPasswordEvent(email: 'email')),
        expect: () => [
          const AuthLoadingState(),
          AuthErrorState(tServerFailure.errorMessage),
        ],
        verify: (_) {
          verify(() => forgotPassword(params: 'email')).called(1);
          verifyNoMoreInteractions(forgotPassword);
        },
      );
    },
  );

  group(
    'update user',
    () {
      blocTest<AuthBloc, AuthState>(
        // ignore: lines_longer_than_80_chars
        'should return AuthLoadingState,UpdateUserState when updateUser sucess',
        build: () {
          when(() => updateUser(params: tUpdateUserParams))
              .thenAnswer((_) async => const Right(null));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          UpdateUserEvent(
            action: tUpdateUserParams.action,
            userData: tUpdateUserParams.userData,
          ),
        ),
        expect: () => [
          const AuthLoadingState(),
          const UserUpdateState(),
        ],
        verify: (_) {
          verify(() => updateUser(params: tUpdateUserParams)).called(1);
          verifyNoMoreInteractions(updateUser);
        },
      );

      blocTest<AuthBloc, AuthState>(
        // ignore: lines_longer_than_80_chars
        'should return AuthLoadingState,AuthErrorState when updateUser failed',
        build: () {
          when(() => updateUser(params: tUpdateUserParams))
              .thenAnswer((_) async => const Left(tServerFailure));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          UpdateUserEvent(
            action: tUpdateUserParams.action,
            userData: tUpdateUserParams.userData,
          ),
        ),
        expect: () => [
          const AuthLoadingState(),
          AuthErrorState(tServerFailure.errorMessage),
        ],
        verify: (_) {
          verify(() => updateUser(params: tUpdateUserParams)).called(1);
          verifyNoMoreInteractions(updateUser);
        },
      );
    },
  );
}
