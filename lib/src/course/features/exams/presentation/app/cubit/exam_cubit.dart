import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/exam.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/exam_question.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/user_exam.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20usecases/get_exam_question.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20usecases/get_exams.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20usecases/get_user_course_exams.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20usecases/get_user_exam.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20usecases/submit_exam.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20usecases/update_exam.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20usecases/upload_exam.dart';

part 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  ExamCubit({
    required GetExamQuestion getExamQuestions,
    required GetExams getExams,
    required SubmitExam submitExam,
    required UpdateExam updateExam,
    required UploadExam uploadExam,
    required GetUserCourseExams getUserCourseExams,
    required GetUserExam getUserExams,
  })  : _getExamQuestions = getExamQuestions,
        _getExams = getExams,
        _submitExam = submitExam,
        _updateExam = updateExam,
        _uploadExam = uploadExam,
        _getUserCourseExams = getUserCourseExams,
        _getUserExams = getUserExams,
        super(const ExamInitial());

  final GetExamQuestion _getExamQuestions;
  final GetExams _getExams;
  final SubmitExam _submitExam;
  final UpdateExam _updateExam;
  final UploadExam _uploadExam;
  final GetUserCourseExams _getUserCourseExams;
  final GetUserExam _getUserExams;

  Future<void> getExamQuestions(Exam exam) async {
    emit(const GettingExamQuestions());
    final result = await _getExamQuestions(params: exam);
    result.fold(
      (failure) => emit(ExamError(failure.errorMessage)),
      (questions) => emit(ExamQuestionsLoaded(questions)),
    );
  }

  Future<void> getExams(String courseId) async {
    emit(const GettingExams());
    final result = await _getExams(params: courseId);
    result.fold(
      (failure) => emit(ExamError(failure.errorMessage)),
      (exams) => emit(ExamsLoaded(exams)),
    );
  }

  Future<void> submitExam(UserExam exam) async {
    emit(const SubmittingExam());
    final result = await _submitExam(params: exam);
    result.fold(
      (failure) => emit(ExamError(failure.errorMessage)),
      (_) => emit(const ExamSubmitted()),
    );
  }

  Future<void> updateExam(Exam exam) async {
    emit(const UpdatingExam());
    final result = await _updateExam(params: exam);
    result.fold(
      (failure) => emit(ExamError(failure.errorMessage)),
      (_) => emit(const ExamUpdated()),
    );
  }

  Future<void> uploadExam(Exam exam) async {
    emit(const UploadingExam());
    final result = await _uploadExam(params: exam);
    result.fold(
      (failure) => emit(ExamError(failure.errorMessage)),
      (_) => emit(const ExamUploaded()),
    );
  }

  Future<void> getUserCourseExams(String courseId) async {
    emit(const GettingUserExams());
    final result = await _getUserCourseExams(params: courseId);
    result.fold(
      (failure) => emit(ExamError(failure.errorMessage)),
      (exams) => emit(UserCourseExamsLoaded(exams)),
    );
  }

  Future<void> getUserExams() async {
    emit(const GettingUserExams());
    final result = await _getUserExams();
    result.fold(
      (failure) => emit(ExamError(failure.errorMessage)),
      (exams) => emit(UserExamsLoaded(exams)),
    );
  }
}
