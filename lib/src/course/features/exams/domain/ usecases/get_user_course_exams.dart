import 'package:fca_education_app/core/usecases/usecases.dart';
import 'package:fca_education_app/core/utils/typedefs.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/user_exam.dart';
import 'package:fca_education_app/src/course/features/exams/domain/repo/exam_repo.dart';

class GetUserCourseExams extends UseCaseWithParams<List<UserExam>, String> {
  GetUserCourseExams({required ExamRepo examRepo}) : _examRepo = examRepo;

  final ExamRepo _examRepo;
  @override
  ResultFuture<List<UserExam>> call({required String params}) {
    return _examRepo.getUserCourseExams(params);
  }
}
