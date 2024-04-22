// ignore_for_file: unused_local_variable, lines_longer_than_80_chars

import 'package:dartz/dartz.dart';
import 'package:fca_education_app/%20core/errors/exception.dart';
import 'package:fca_education_app/%20core/errors/failure.dart';
import 'package:fca_education_app/src/course/data/datasources/course_remote_data_sources.dart';
import 'package:fca_education_app/src/course/data/model/course_model.dart';
import 'package:fca_education_app/src/course/data/repo/course_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCourseRemoteDataSrc extends Mock implements CourseRemtoeDataSrc {}

void main() {
  late CourseRemtoeDataSrc courseRemoteDataSrc;
  late CourseRepoImpl courseRepoImpl;

  final tCourse = CourseModel.empty();

  const tException = ServerException(
    message: 'Something went wrong',
    statusCode: '500',
  );

  setUp(
    () {
      courseRemoteDataSrc = MockCourseRemoteDataSrc();
      courseRepoImpl = CourseRepoImpl(courseRemoteDataSrc);
      registerFallbackValue(tCourse);
    },
  );

 

  group(
    'add Course',
    () {
      test(
        'should complete sucessfully when call to remote source is sucessful',
        () async {
          // arrange
          when(() => courseRemoteDataSrc.addCourse(tCourse))
              .thenAnswer((_) async => Future.value());

          // act
          final result = await courseRepoImpl.addCourse(tCourse);

          // expect
          expect(result, const Right<dynamic, void>(null));

          verify(() => courseRemoteDataSrc.addCourse(tCourse)).called(1);
          verifyNoMoreInteractions(courseRemoteDataSrc);
        },
      );

      test(
        'should return serverExceptionnn when call to remote source is unsucessful',
        () async {
          // arrange
          when(() => courseRemoteDataSrc.addCourse(tCourse))
              .thenThrow(tException);

          // act
          final result = await courseRepoImpl.addCourse(tCourse);

          // expect
          expect(
            result,
            Left<Failure, void>(
              ServerFailure.fromException(serverException: tException),
            ),
          );

          verify(() => courseRemoteDataSrc.addCourse(tCourse)).called(1);
          verifyNoMoreInteractions(courseRemoteDataSrc);
        },
      );
    },
  );

  group(
    'getCourse',
    () {
      final tListCousrse = [tCourse];
      test(
        'should return List<Course> when call to remote source is sucessful',
        () async {
          // arrange
          when(() => courseRemoteDataSrc.getCourses()).thenAnswer(
            (_) async => tListCousrse,
          );

          // act
          final result = await courseRepoImpl.getCourse();

          // expect
          expect(result, Right<dynamic, List<CourseModel>>(tListCousrse));

          verify(() => courseRemoteDataSrc.getCourses()).called(1);
          verifyNoMoreInteractions(courseRemoteDataSrc);
        },
      );

      test(
        'should return SeverFailure when call to remote source is unsucessful',
        () async {
          // arrange
          when(() => courseRemoteDataSrc.getCourses()).thenThrow(tException);

          // act
          final result = await courseRepoImpl.getCourse();

          // expect
          expect(
            result,
            Left<Failure, dynamic>(
              ServerFailure.fromException(serverException: tException),
            ),
          );

          verify(() => courseRemoteDataSrc.getCourses()).called(1);
          verifyNoMoreInteractions(courseRemoteDataSrc);
        },
      );
    },
  );
}
