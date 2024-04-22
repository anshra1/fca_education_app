part of 'course_cubit.dart';

abstract class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object> get props => [];
}

class CourseInitialState extends CourseState {
  const CourseInitialState();
}

class CourseErrorState extends CourseState {
  const CourseErrorState(this.message);

  final String message;
}

class LoadingCoursesState extends CourseState {
  const LoadingCoursesState();
}

class AdddingCoursesState extends CourseState {
  const AdddingCoursesState();
}

class CourseAddedState extends CourseState {
  const CourseAddedState();
}

class CourseLoadedState extends CourseState {
  const CourseLoadedState(this.courses);

  final List<Course> courses;
}
