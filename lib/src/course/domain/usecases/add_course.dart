import 'package:fca_education_app/core/usecases/usecases.dart';
import 'package:fca_education_app/core/utils/typedefs.dart';
import 'package:fca_education_app/src/course/domain/entites/entites.dart';
import 'package:fca_education_app/src/course/domain/repo/course_repo.dart';

class AddCourses extends UseCaseWithParams<void, Course> {
  AddCourses({required CourseRepo courseRepo}) : _courseRepo = courseRepo;

  final CourseRepo _courseRepo;

  @override
  ResultFuture<void> call({required Course params}) {
    return _courseRepo.addCourse(params);
  }
}
