import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fca_education_app/src/on_boarding/domain/usecase/cache_first_timer.dart';
import 'package:fca_education_app/src/on_boarding/domain/usecase/check_user_is_first_timer.dart';

import 'package:fca_education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCacheFirstTimer extends Mock implements CacheFirstTimer {}

class MockCheckUserIsFirstTimer extends Mock implements CheckUserIsFirstTimer {}

void main() {
  group('OnBoardingCubit', () {
    late OnBoardingCubit onBoardingCubit;
    late MockCacheFirstTimer cacheFirstTimer;
    late MockCheckUserIsFirstTimer checkIfUserIsFirstTimer;

    setUp(() {
      cacheFirstTimer = MockCacheFirstTimer();
      checkIfUserIsFirstTimer = MockCheckUserIsFirstTimer();

      onBoardingCubit = OnBoardingCubit(
        cachingFirstTimer: cacheFirstTimer,
        checkIfUserIsFirstTimervoid: checkIfUserIsFirstTimer,
        
      );
    });

    group('cache FirstTimer', () {
      blocTest<OnBoardingCubit, OnBoardingState>(
        'should emit cachingFirstTimer when success',
        build: () {
          when(
            () => cacheFirstTimer(), // Corrected method call
          ).thenAnswer(
            (invocation) async => const Right(null),
          );
          return onBoardingCubit;
        },
        act: (bloc) => bloc.cacheFirstTimer(), // Corrected method name
        expect: () => <OnBoardingState>[
          const CachingFirstTimer(),
          const UserCached(),
        ],
        verify: (_) {
          verify(() => onBoardingCubit.cachingFirstTimer())
              .called(1); // Corrected method call
          verifyNoMoreInteractions(cacheFirstTimer);
        },
      );
    });
  });
}
