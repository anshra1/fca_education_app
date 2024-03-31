import 'package:dartz/dartz.dart';
import 'package:fca_education_app/%20core/errors/exception.dart';
import 'package:fca_education_app/%20core/errors/failure.dart';
import 'package:fca_education_app/src/on_boarding/data/datasources/on_boarding_local_data_src.dart';
import 'package:fca_education_app/src/on_boarding/data/repo/on_boarding_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnBoardingLocalDataSrc extends Mock
    implements OnBoardingLocalDataSrc {}

const cacheException = CacheException(
  message: 'error',
  statusCode: 300,
);

void main() {
  group(
    'OnBoardingRepoImpl',
    () {
      late OnBoardingRepoImpl repo;
      late OnBoardingLocalDataSrc mockOnBoardingLocalDataSrc;

      setUp(() {
        mockOnBoardingLocalDataSrc = MockOnBoardingLocalDataSrc();
        repo = OnBoardingRepoImpl(
          onBoardingLocalDataSrc: mockOnBoardingLocalDataSrc,
        );
      });

      test('cacheFirstTimer calls cacheFirstTimer on OnBoardingLocalDataSrc',
          () async {
        when(() => mockOnBoardingLocalDataSrc.cacheFirstTimer())
            .thenAnswer((_) async => const Right<ServerFailure, dynamic>(null));

        await repo.cacheFirstTimer();

        verify(() => mockOnBoardingLocalDataSrc.cacheFirstTimer()).called(1);
      });

      test(
          'cacheFirstTimer returns Right(null) when cacheFirstTimer on'
          ' OnBoardingLocalDataSrc succeeds', () async {
        when(() => mockOnBoardingLocalDataSrc.cacheFirstTimer()).thenAnswer(
          (_) async => Future.value(),
        );

        final result = await repo.cacheFirstTimer();

        expect(result, const Right<ServerFailure, void>(null));
        verify(() => mockOnBoardingLocalDataSrc.cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(mockOnBoardingLocalDataSrc);
      });

      test(
        'cacheFirstTimer returns Left(CacheFailure) when cacheFirstTimer on '
        'OnBoardingLocalDataSrc throws CacheException',
        () async {
          when(() => mockOnBoardingLocalDataSrc.cacheFirstTimer())
              .thenThrow(cacheException);

          final result = await repo.cacheFirstTimer();

          expect(
            result,
            Left<Failure, dynamic>(
              CacheFailure.fromException(cacheException: cacheException),
            ),
          );

          verify(() => mockOnBoardingLocalDataSrc.cacheFirstTimer()).called(1);
          verifyNoMoreInteractions(mockOnBoardingLocalDataSrc);
        },
      );
    },
  );
}
