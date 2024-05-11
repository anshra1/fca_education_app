import 'package:fca_education_app/core/usecases/usecases.dart';
import 'package:fca_education_app/core/utils/typedefs.dart';
import 'package:fca_education_app/src/course/domain/entites/entites.dart';
import 'package:fca_education_app/src/course/domain/repo/course_repo.dart';

class GetCourse extends UseCaseWithoutParam<List<Course>> {
  GetCourse({
    required CourseRepo courseRepo,
  }) : _courseRepo = courseRepo;

  final CourseRepo _courseRepo;

  @override
  ResultFuture<List<Course>> call() {
    return _courseRepo.getCourse();
  }
}
