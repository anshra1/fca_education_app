// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:fca_education_app/core/errors/failure.dart';
import 'package:fca_education_app/src/auth/domain/auth_repo.dart/atuh_repo.dart';
import 'package:fca_education_app/src/auth/domain/entites/local_user.dart';
import 'package:fca_education_app/src/auth/domain/usecases/sign_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepo {}

void main() {
  late AuthRepo authRepo;
  late SignIn signIn;
  setUp(
    () {
      authRepo = MockAuthRepository();
      signIn = SignIn(authRepo);
    },
  );

  group(
    'sign in',
    () {
      test(
        'should return void when called forget password',
        () async {
          // arrange
          when(
            () => authRepo.signIn(email: 'email', password: 'password'),
            // ignore: null_argument_to_non_null_type
          ).thenAnswer((_) async => Right(LocalUser.empty()));

          // act
          // ignore: lines_longer_than_80_chars
          final result = await signIn(
            params: const SignInParams(email: 'email', password: 'password'),
          );

          // assert
          expect(result, Right<Failure, LocalUser>(LocalUser.empty()));

          verify(() => authRepo.signIn(email: 'email', password: 'password'));
          verifyNoMoreInteractions(authRepo);
        },
      );
    },
  );
}
