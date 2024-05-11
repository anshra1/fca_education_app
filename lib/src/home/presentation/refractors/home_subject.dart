import 'package:fca_education_app/core/common/widgets/course_tile.dart';
import 'package:fca_education_app/core/extensions/context_extension.dart';
import 'package:fca_education_app/core/res/colors.dart';
import 'package:fca_education_app/src/course/domain/entites/entites.dart';
import 'package:fca_education_app/src/course/presentation/views/all_course_view.dart';
import 'package:fca_education_app/src/course/presentation/views/course_detail_view.dart';
import 'package:fca_education_app/src/home/presentation/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeSubject extends StatelessWidget {
  const HomeSubject({required this.courses, super.key});

  final List<Course> courses;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          sectionTitle: 'Courses',
          seeAll: courses.length > 4,
          onPreesed: () => context.push(AllCourseView(courses: courses)),
        ),
        const Text(
          'Explore our courses',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colours.neutralTextColour,
          ),
        ),
        const Gap(20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: courses
              .take(4)
              .map(
                (course) => CourseTile(
                  course: course,
                  voidCallback: () => Navigator.of(context).pushNamed(
                    CourseDetailView.routeName,
                    arguments: course,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
