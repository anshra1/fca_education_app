import 'package:fca_education_app/core/utils/typedefs.dart';
import 'package:fca_education_app/src/course/domain/entites/entites.dart';

abstract class CourseRepo {
  ResultFuture<void> addCourse(Course course);
  ResultFuture<List<Course>> getCourse();
}
