import 'package:fca_education_app/core/usecases/usecases.dart';
import 'package:fca_education_app/core/utils/typedefs.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/user_exam.dart';
import 'package:fca_education_app/src/course/features/exams/domain/repo/exam_repo.dart';

class SubmitExam extends UseCaseWithParams<void, UserExam> {
  SubmitExam({required ExamRepo examRepo}) : _examRepo = examRepo;

  final ExamRepo _examRepo;
  @override
  ResultFuture<void> call({required UserExam params}) {
    return _examRepo.submitExam(params);
  }
}
