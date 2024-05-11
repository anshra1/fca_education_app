import 'package:fca_education_app/core/usecases/usecases.dart';
import 'package:fca_education_app/core/utils/typedefs.dart';
import 'package:fca_education_app/src/course/features/exams/domain/%20entites/exam.dart';
import 'package:fca_education_app/src/course/features/exams/domain/repo/exam_repo.dart';

class UploadExam extends UseCaseWithParams<void, Exam> {
  UploadExam({required ExamRepo examRepo}) : _examRepo = examRepo;

  final ExamRepo _examRepo;

  @override
  ResultFuture<void> call({required Exam params}) {
    return _examRepo.uploadExam(params);
  }
}
