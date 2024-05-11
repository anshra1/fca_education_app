import 'package:fca_education_app/core/usecases/usecases.dart';
import 'package:fca_education_app/core/utils/typedefs.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/exam.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/exam_question.dart';
import 'package:fca_education_app/src/course/features/exams/domain/repo/exam_repo.dart';

class GetExamQuestion extends UseCaseWithParams<List<ExamQuestion>, Exam> {
  GetExamQuestion({
    required ExamRepo examRepo,
  }) : _examRepo = examRepo;

  final ExamRepo _examRepo;

  @override
  ResultFuture<List<ExamQuestion>> call({required Exam params}) {
    return _examRepo.getExamQuestions(params);
  }
}
