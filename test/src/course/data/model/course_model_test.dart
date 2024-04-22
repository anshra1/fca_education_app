import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fca_education_app/%20core/utils/typedefs.dart';
import 'package:fca_education_app/src/course/data/model/course_model.dart';
import 'package:fca_education_app/src/course/domain/entites/entites.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final timestampData = {
    '_seconds': 1677483548,
    '_nanoSeconds': 123456000,
  };

  final date =
      DateTime.fromMillisecondsSinceEpoch(timestampData['_seconds'] as int)
          .add(Duration(microseconds: timestampData['_nanoSeconds'] as int));

  final timesTamp = Timestamp.fromDate(date);

  final tCourseModel = CourseModel.empty();

  final tMap = jsonDecode(fixture('course.json')) as DataMap;
  tMap['createdAt'] = timesTamp;
  tMap['updatedAt'] = timesTamp;

  test(
    'shold be subclass of entity',
    () async {
      expect(tCourseModel, isA<Course>());
    },
  );

  group(
    'empty',
    () {
      test(
        'should return a [CourseModel] with empty data',
        () async {
          final result = CourseModel.empty();
          expect(result.title, '_empty.title');
        },
      );
    },
  );

  group(
    'from Map',
    () {
      test(
        'should return a [CourseModel] with correct data',
        () async {
          final result = CourseModel.fromMap(tMap);

          expect(result.runtimeType, equals(tCourseModel.runtimeType));
        },
      );
    },
  );

  group(
    'toMap',
    () {
      test(
        'should return a [Map] with the proper data',
        () async {
          final result = tCourseModel.toMap()
            ..remove('createdAt')
            ..remove('updatedAt');

          final map = Map<String, dynamic>.from(tMap)
            ..remove('createdAt')
            ..remove('updatedAt');

          expect(result, map);
        },
      );
    },
  );

  group(
    'copy with',
    () {
      test(
        'should return a [CourseModel] with the new data',
        () async {
          final result = tCourseModel.copyWith(title: 'New Title');
          expect(result.title, 'New Title');
        },
      );
    },
  );
}
