import 'package:fca_education_app/%20core/common/app/providers/course_of_the_notifier.dart';
import 'package:fca_education_app/%20core/common/views/loading_view.dart';
import 'package:fca_education_app/%20core/common/widgets/not_found_text.dart';
import 'package:fca_education_app/%20core/extensions/context_extension.dart';
import 'package:fca_education_app/%20core/utils/core_utils.dart';
import 'package:fca_education_app/src/course/presentation/cubit/course_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  void getCourses() {
    context.read<CourseCubit>().getCourses();
  }

  @override
  void initState() {
    super.initState();
    getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseCubit, CourseState>(
      listener: (context, state) {
        if (state is CourseErrorState) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is CourseLoadedState && state.courses.isNotEmpty) {
          final courses = state.courses..shuffle();
          final courseOfTheDay = courses.first;
          context
              .read<CourseOfTheDayNotifier>()
              .setCourseOfTheDay(courseOfTheDay);
        }
      },
      builder: (context, state) {
        if (state is LoadingCoursesState) {
          return const Loadingview();
        } else if (state is CourseLoadedState && state.courses.isEmpty ||
            state is CourseErrorState) {
          return const NotFoundText(
              text:
                  'No courses is found \nPlease contact admin or if you are admin, '
                  'add courses');
        }
        
        state as CourseLoadedState;

        final courses = state.courses
          ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [],
        );
      },
    );
  }
}
