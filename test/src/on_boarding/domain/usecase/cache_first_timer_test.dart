import 'package:dartz/dartz.dart';
import 'package:fca_education_app/%20core/errors/failure.dart';
import 'package:fca_education_app/src/on_boarding/domain/repo/on_boarding_repo.dart';
import 'package:fca_education_app/src/on_boarding/domain/usecase/cache_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnBoardingRepo extends Mock implements OnBoardingRepo {}

void main() {
  group('CacheFirstTimer', () {
    late CacheFirstTimer cacheFirstTimer;
    late OnBoardingRepo mockRepo;

    setUp(() {
      mockRepo = MockOnBoardingRepo();
      cacheFirstTimer = CacheFirstTimer(repo: mockRepo);
    });

    const tServerFailure = ServerFailure(
      message: 'message',
      statusCode: 'statusCode',
    );

    test('should call cacheFirstTimer and return void', () async {
      // Arrange
      when(() => mockRepo.cacheFirstTimer()).thenAnswer(
        (_) async => const Left(tServerFailure),
      );

      // Act
      final result = await cacheFirstTimer.call();

      // Assert
      expect(
        result,
        const Left<ServerFailure, dynamic>(tServerFailure),
      );
      verify(() => mockRepo.cacheFirstTimer()).called(1);
    });
  });
} 
