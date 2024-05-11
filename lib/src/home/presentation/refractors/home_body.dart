import 'package:fca_education_app/core/common/app/providers/course_of_the_notifier.dart';
import 'package:fca_education_app/core/common/views/loading_view.dart';
import 'package:fca_education_app/core/common/widgets/not_found_text.dart';
import 'package:fca_education_app/core/utils/core_utils.dart';
import 'package:fca_education_app/src/course/presentation/cubit/course_cubit.dart';
import 'package:fca_education_app/src/home/presentation/refractors/home_header.dart';
import 'package:fca_education_app/src/home/presentation/refractors/home_subject.dart';
import 'package:fca_education_app/src/home/presentation/refractors/home_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

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
                // ignore: lines_longer_than_80_chars
                'No courses is found\nPlease contact admin or if you are admin, '
                'add courses',
          );
        }

        state as CourseLoadedState;

        final courses = state.courses
          ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const HomeHeader(),
            const Gap(20),
            HomeSubject(courses: courses),
            const Gap(20),
            const HomeVideos(),
          ],
        );
      },
    );
  }
}
