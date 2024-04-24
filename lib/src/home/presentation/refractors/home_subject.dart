import 'package:fca_education_app/%20core/extensions/context_extension.dart';
import 'package:fca_education_app/%20core/res/colors.dart';
import 'package:fca_education_app/src/course/domain/entites/entites.dart';
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
          onPreesed: () => context.push(const Placeholder()),
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
          children: courses.take(4).map((e) => CourseTile()).toList(),
        )
      ],
    );
  }
}
