import 'package:fca_education_app/%20core/usecases/usecases.dart';
import 'package:fca_education_app/%20core/utils/typedefs.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/user_exam.dart';
import 'package:fca_education_app/src/course/features/exams/domain/repo/exam_repo.dart';

class GetUserExam extends UseCaseWithoutParam<List<UserExam>> {
  GetUserExam({required ExamRepo examRepo}) : _examRepo = examRepo;

  final ExamRepo _examRepo;
  @override
  ResultFuture<List<UserExam>> call() {
    return _examRepo.getUserExams();
  }
}
