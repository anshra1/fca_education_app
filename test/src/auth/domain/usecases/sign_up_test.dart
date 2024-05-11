import 'package:dartz/dartz.dart';
import 'package:fca_education_app/core/errors/failure.dart';
import 'package:fca_education_app/src/auth/domain/auth_repo.dart/atuh_repo.dart';

import 'package:fca_education_app/src/auth/domain/usecases/sign_up.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepo {}

void main() {
  late AuthRepo authRepo;
  late SignUp signUp;
  setUp(
    () {
      authRepo = MockAuthRepository();
      signUp = SignUp(authRepo);
    },
  );

  group(
    'sign up',  
    () {
      test(
        'should return void when called forget password',
        () async {
          // arrange
          when(
            () => authRepo.signUp(
              email: 'email',
              fullName: 'name',
              password: 'password',
            ),
            // ignore: null_argument_to_non_null_type
          ).thenAnswer((_) async => const Right(null));

          // act

          final result = await signUp(
            params: const SignUpParams(
              email: 'email',
              fullName: 'name',
              password: 'password',
            ),
          );

          // assert
          expect(result, const Right<Failure, void>(null));

          verify(
            () => authRepo.signUp(
                email: 'email', password: 'password', fullName: 'name',),
          ).called(1);
          verifyNoMoreInteractions(authRepo);
        },
      );
    },
  );
}
