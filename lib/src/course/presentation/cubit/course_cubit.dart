import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fca_education_app/src/course/domain/entites/entites.dart';
import 'package:fca_education_app/src/course/domain/usecases/add_course.dart';
import 'package:fca_education_app/src/course/domain/usecases/get_course.dart';

part 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit({
    required AddCourses addCourse,
    required GetCourse getCourse,
  })  : _addCourse = addCourse,
        _getCourse = getCourse,
        super(const CourseInitialState());

  final AddCourses _addCourse;
  final GetCourse _getCourse;

  Future<void> addCourse(Course course) async {
    emit(const AdddingCoursesState());

    final result = await _addCourse(params: course);

    result.fold(
      (failure) => emit(CourseErrorState(failure.errorMessage)),
      (_) => emit(const CourseAddedState()),
    );
  }

  Future<void> getCourses() async {
    emit(const LoadingCoursesState());

    final result = await _getCourse();

    result.fold(
     (failure) => emit(CourseErrorState(failure.errorMessage)),
      (courses) => emit(CourseLoadedState(courses)),
    );
  }
}
