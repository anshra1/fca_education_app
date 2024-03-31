import 'package:fca_education_app/%20core/errors/exception.dart';
import 'package:fca_education_app/src/on_boarding/data/datasources/on_boarding_local_data_src.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences prefs;
  late OnBoardingLocalDataSrc localDataSrc;

  setUp(
    () {
      prefs = MockSharedPreferences();
      localDataSrc = OnBoardingLocalDataSrcImpl(prefs: prefs);
    },
  );

  group(
    'cacheFirstTimer',
    () {
      test(
        'should call SharedPreferences.setBool to cache first timer',
        () async {
          when(() => prefs.setBool(kFirstTimer, false)).thenAnswer(
            (_) async => true,
          );

          await localDataSrc.cacheFirstTimer();
          verify(() => prefs.setBool(kFirstTimer, false)).called(1);
          verifyNoMoreInteractions(prefs);
        },
      );

      test(
        'shold throw a cache Excep.tion when there is an error the data',
        () async {
          when(() => prefs.setBool(kFirstTimer, false)).thenThrow(
            Exception(),
          );

          final methodCall = localDataSrc.cacheFirstTimer;

          expect(methodCall(), throwsA(isA<CacheException>()));

          verify(() => prefs.setBool(kFirstTimer, false)).called(1);

          verifyNoMoreInteractions(prefs);
        },
      );
    },
  );
  group(
    'checkIfUserIsFirstTimer',
    () {
      test(
        'should call SharedPreferences.getBool to check if user is first timer '
        'return the right response froom storage when data exists',
        () async {
          when(() => prefs.getBool(kFirstTimer)).thenReturn(false);

          final result = await localDataSrc.checkIfUserIsFirstTimer();

          expect(result, false);

          verify(() => prefs.getBool(kFirstTimer)).called(1);

          verifyNoMoreInteractions(prefs);
        },
      );

      test(
        'shold return true if there is no data in storage',
        () async {
          when(() => prefs.getBool(kFirstTimer)).thenReturn(null);

          final result = await localDataSrc.checkIfUserIsFirstTimer();

          expect(result, true);

          verify(() => prefs.getBool(kFirstTimer)).called(1);

          verifyNoMoreInteractions(prefs);
        },
      );

      test(
        'shold return a cache Exception if there is error',
        () async {
          when(
            () => prefs.getBool(kFirstTimer),
          ).thenThrow(
            Exception(),
          );

          final result =  localDataSrc.checkIfUserIsFirstTimer();

          expect(result, throwsA(isA<CacheException>()));

          verify(() => prefs.getBool(kFirstTimer)).called(1);

          verifyNoMoreInteractions(prefs);
        },
      );
    },
  );
}
