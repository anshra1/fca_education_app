import 'package:dartz/dartz.dart';
import 'package:fca_education_app/%20core/errors/exception.dart';
import 'package:fca_education_app/%20core/errors/failure.dart';
import 'package:fca_education_app/%20core/utils/typedefs.dart';
import 'package:fca_education_app/src/course/features/exams/data/datasources/exam_remote_data_src.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/exam.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/exam_question.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/user_exam.dart';
import 'package:fca_education_app/src/course/features/exams/domain/repo/exam_repo.dart';

class ExamRepoImpl implements ExamRepo {
  const ExamRepoImpl(this._remoteDataSource);

  final ExamRemoteDataSrc _remoteDataSource;

  @override
  ResultFuture<List<Exam>> getExams(String courseId) async {
    try {
      final result = await _remoteDataSource.getExams(courseId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(serverException: e));
    }
  }

  @override
  ResultFuture<void> uploadExam(Exam exam) async {
    try {
      await _remoteDataSource.uploadExam(exam);
      return const Right(null);
    } on ServerException catch (e) {
     return Left(ServerFailure.fromException(serverException: e));
    }
  }

  @override
  ResultFuture<void> updateExam(Exam exam) async {
    try {
      await _remoteDataSource.updateExam(exam);
      return const Right(null);
    } on ServerException catch (e) {
     return Left(ServerFailure.fromException(serverException: e));
    }
  }

  @override
  ResultFuture<void> submitExam(UserExam exam) async {
    try {
      await _remoteDataSource.submitExam(exam);
      return const Right(null);
    } on ServerException catch (e) {
     return Left(ServerFailure.fromException(serverException: e));
    }
  }

  @override
  ResultFuture<List<ExamQuestion>> getExamQuestions(Exam exam) async {
    try {
      final result = await _remoteDataSource.getExamQuestions(exam);
      return Right(result);
    } on ServerException catch (e) {
     return Left(ServerFailure.fromException(serverException: e));
    }
  }

  @override
  ResultFuture<List<UserExam>> getUserExams() async {
    try {
      final result = await _remoteDataSource.getUserExams();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(serverException: e));
    }
  }

  @override
  ResultFuture<List<UserExam>> getUserCourseExams(String courseId) async {
    try {
      final result = await _remoteDataSource.getUserCourseExams(courseId);
      return Right(result);
    } on ServerException catch (e) {
     return Left(ServerFailure.fromException(serverException: e));
    }
  }
}
