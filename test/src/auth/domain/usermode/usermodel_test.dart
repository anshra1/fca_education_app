import 'dart:convert';

import 'package:fca_education_app/%20core/utils/typedefs.dart';
import 'package:fca_education_app/src/auth/datasources/models/user_model.dart';
import 'package:fca_education_app/src/auth/domain/entites/local_user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tLocaluser = LocalUserModel.empty();

  test(
    'should be subclass of LocalUser entity',
    () {
      // assert
      expect(tLocaluser, isA<LocalUser>());
    },
  );

  group(
    'from Map',
    () {
      final tMap = jsonDecode(fixture('user.json')) as DataMap;
      test(
        'should return a valid LocalUserModel from Map',
        () {
          final result = LocalUserModel.fromMap(map: tMap);
          expect(result, equals(tLocaluser));
          expect(result, isA<LocalUserModel>());
        },
      );

      test(
        'should throws a Error when Map is invalid',
        () {
          final map = tMap..remove('uid');
          const call = LocalUserModel.fromMap;
          expect(
            () => call(map: map),
            throwsA(isA<Error>()),
          );
        },
      );
    },
  );

  group(
    'toMap',
    () {
      test(
        'should return a valid DataMap from LocalUserModel',
        () {
          final result = tLocaluser.toMap();
          expect(result, isA<DataMap>());
        },
      );
    },
  );

  group(
    'copy with',
    () {
      test(
        'should return a valid localUserModel with new values',
        () {
          final result = tLocaluser.copyWith(uid: '2');
          expect(result.uid,'2');
        },
      );
    },
  );
}
