import 'package:dartz/dartz.dart';
import 'package:fca_education_app/core/enum/user_data.dart';
import 'package:fca_education_app/core/errors/failure.dart';
import 'package:fca_education_app/src/auth/domain/auth_repo.dart/atuh_repo.dart';

import 'package:fca_education_app/src/auth/domain/usecases/update_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepo {}

void main() {
  late AuthRepo authRepo;
  late UpdateUser updateUser;
  setUp(
    () {
      authRepo = MockAuthRepository();
      updateUser = UpdateUser(authRepo);
    },
  );

  group(
    'update user',
    () {
      test(
        'should return void when called forget password',
        () async {
          // arrange
          when(
            () => authRepo.updateUser(
              action: UpdateUserAction.displyName,
              userData: 'user',
            ),
          ).thenAnswer((_) async => const Right(null));

          // act

          final result = await updateUser(
            params: const UpdateUserParams(
              action: UpdateUserAction.displyName,
              userData: 'user',
            ),
          );

          // assert
          expect(result, const Right<Failure, void>(null));

          verify(
            () => authRepo.updateUser(
              action: UpdateUserAction.displyName,
              userData: 'user',
            ),
          ).called(1);
          verifyNoMoreInteractions(authRepo);
        },
      );
    },
  );
}
