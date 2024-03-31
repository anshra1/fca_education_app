import 'dart:ffi';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fca_education_app/%20core/errors/exception.dart';
import 'package:fca_education_app/%20core/errors/failure.dart';
import 'package:fca_education_app/src/on_boarding/domain/usecase/cache_first_timer.dart';
import 'package:fca_education_app/src/on_boarding/domain/usecase/check_user_is_first_timer.dart';

import 'package:fca_education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCacheFirstTimer extends Mock implements CacheFirstTimer {}

class MockCheckUserIsFirstTimer extends Mock implements CheckUserIsFirstTimer {}

void main() {
  group(
    'OnBoardingCubit',
    () {
      late OnBoardingCubit cubit;
      late CacheFirstTimer cacheFirstTimer;
      late CheckUserIsFirstTimer checkIfUserIsFirstTimer;

      setUp(() {
        cacheFirstTimer = MockCacheFirstTimer();
        checkIfUserIsFirstTimer = MockCheckUserIsFirstTimer();

        cubit = OnBoardingCubit(
          cachingFirstTimer: cacheFirstTimer,
          checkIfUserIsFirstTimervoid: checkIfUserIsFirstTimer,
        );
      });

      group('cache FirstTimer', () {
        blocTest<OnBoardingCubit, OnBoardingState>(
          'should emit cachingFirstTimer when sucesss',
          build: () {
            when(
              () => cacheFirstTimer(),
            ).thenAnswer(
              (invocation) async => const Right(null),
            );
            return cubit;
          },
          act: (bloc) => cubit.cacheFirstTimer(),
          expect: () => <OnBoardingState>[
            const CachingFirstTimer(),
            const UserCached(),
          ],
          verify: (_) {
            verify(() => cacheFirstTimer()).called(1);
            verifyNoMoreInteractions(cacheFirstTimer);
          },
        );

        blocTest<OnBoardingCubit, OnBoardingState>(
          'should emit cachingFirstTimer and onboardingError when error',
          build: () {
            when(
              () => cacheFirstTimer(),
            ).thenAnswer(
              (invocation) async => const Left(
                CacheFailure(
                  message: 'message',
                  statusCode: 4032,
                ),
              ),
            );

            return cubit;
          },
          act: (bloc) => cubit.cacheFirstTimer(),
          expect: () => <OnBoardingState>[
            const CachingFirstTimer(),
            const OnBoardingError(message: 'message'),
          ],
          verify: (_) {
            verify(() => cacheFirstTimer()).called(1);
            verifyNoMoreInteractions(cacheFirstTimer);
          },
        );
      });

      group(
        'checkUserisFirstTiemr',
        () {
          blocTest<OnBoardingCubit, OnBoardingState>(
            // ignore: lines_longer_than_80_chars
            'should emit checkIfUserisFirstTime and userStatus is false when success',
            build: () {
              when(() => checkIfUserIsFirstTimer()).thenAnswer(
                (invocation) async => const Right(false),
              );
              return cubit;
            },
            act: (bloc) => cubit.checkIfUserIsFirstTimer(),
            expect: () => <OnBoardingState>[
              const CheckIfUserIsFirstTimer(),
              const OnBoardingStatus(isFirstTimer: false),
            ],
            verify: (_) {
              verify(() => checkIfUserIsFirstTimer()).called(1);
              verifyNoMoreInteractions(checkIfUserIsFirstTimer);
            },
          );

          blocTest<OnBoardingCubit, OnBoardingState>(
            // ignore: lines_longer_than_80_chars
            'should emit checkIfUserisFirstTime and userStatus is true when unsuccess',
            build: () {
              when(() => checkIfUserIsFirstTimer()).thenAnswer(
                (invocation) async => const Left(
                  CacheFailure(
                    message: 'message',
                    statusCode: 4032,
                  ),
                 ),
              );
              return cubit;
            },
            act: (bloc) => cubit.checkIfUserIsFirstTimer(),
            expect: () => <OnBoardingState>[
              const CheckIfUserIsFirstTimer(),
              const OnBoardingStatus(isFirstTimer: true),
            ],
            verify: (_) {
              verify(() => checkIfUserIsFirstTimer()).called(1);
              verifyNoMoreInteractions(checkIfUserIsFirstTimer);
            },
          );
        },
      );
    },
  );
}
