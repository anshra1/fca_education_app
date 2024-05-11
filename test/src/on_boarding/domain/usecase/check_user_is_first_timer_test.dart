import 'package:dartz/dartz.dart';
import 'package:fca_education_app/core/errors/failure.dart';
import 'package:fca_education_app/src/on_boarding/domain/repo/on_boarding_repo.dart';
import 'package:fca_education_app/src/on_boarding/domain/usecase/check_user_is_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnBoardingRepo extends Mock implements OnBoardingRepo {}

void main() {
  group('checkIfUserIsFirstTimer', () {
    late CheckUserIsFirstTimer firstTimer;
    late OnBoardingRepo mockRepo;

    setUp(() {
      mockRepo = MockOnBoardingRepo();
      firstTimer = CheckUserIsFirstTimer(repo: mockRepo);
    });

    test('should call checkIfUserIsFirstTimer and return true', () async {
      // Arrange
      when(() => mockRepo.checkIfUserIsFirstTimer()).thenAnswer(
        (_) async => const Right(true),
      );

      // Act
      final result = await firstTimer.call();

      // Assert
      expect(result, const Right<ServerFailure, bool>(true));
      verify(() => mockRepo.checkIfUserIsFirstTimer()).called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });
}
