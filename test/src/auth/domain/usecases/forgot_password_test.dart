import 'package:dartz/dartz.dart';
import 'package:fca_education_app/core/errors/failure.dart';
import 'package:fca_education_app/src/auth/domain/auth_repo.dart/atuh_repo.dart';
import 'package:fca_education_app/src/auth/domain/usecases/forgot_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepo {}

void main() {
  late AuthRepo authRepo;
  late ForgotPassword forgotPassword;
  setUp(
    () {
      authRepo = MockAuthRepository();
      forgotPassword = ForgotPassword(authRepo);
    },
  );

  group(
    'forget Password',
    () {
      test(
        'should return void when called forget password',
        ()async {
          // arrange
          when(
            () => authRepo.forgotPassword(email: 'email'),
            // ignore: null_argument_to_non_null_type
          ).thenAnswer((_) async => const Right(null));

          // act
          final result = await forgotPassword(params:  'email');
          // assert
          expect(result, const Right<Failure,void>(null));
          verify(() => authRepo.forgotPassword(email: 'email')).called(1);
          verifyNoMoreInteractions(authRepo);
        },
      );
    },
  );
}
