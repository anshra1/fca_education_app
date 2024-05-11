import 'package:fca_education_app/core/common/widgets/course_info_tile.dart';
import 'package:fca_education_app/core/common/widgets/expandable_text.dart';
import 'package:fca_education_app/core/common/widgets/gradient_background.dart';
import 'package:fca_education_app/core/common/widgets/nested_back_button.dart';
import 'package:fca_education_app/core/extensions/context_extension.dart';
import 'package:fca_education_app/core/extensions/int_extension.dart';
import 'package:fca_education_app/core/res/media_res.dart';
import 'package:fca_education_app/src/course/domain/entites/entites.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';

class CourseDetailView extends StatelessWidget {
  const CourseDetailView({required this.course, super.key});

  static const routeName = '/course-details';
  final Course course;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const NestedBackButton(),
        title: Text(course.title),
      ),
      body: GradientBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              SizedBox(
                height: context.height * .3,
                child: Center(
                  child: course.image != null
                      ? Image.network(course.image!)
                      : Image.asset(
                          MediaResources.casualMeditation,
                        ),
                ),
              ),
              const Gap(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(10),
                  if (course.description != null)
                    ExpandableText(context: context, text: course.description!),
                  if (course.numberOfMaterials > 0 ||
                      course.numberOfVideos > 0 ||
                      course.numberOfExams > 0) ...[
                    const Gap(20),
                    const Text(
                      'Subject Details',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (course.numberOfVideos > 0) ...[
                      const Gap(10),
                      CourseInfoTile(
                        image: const Icon(IconlyLight.video),
                        title: '${course.numberOfVideos} Video(s)',
                        subTitle: 'Watch our tutorial '
                            'videos for ${course.title}',
                        onPressed: () => Navigator.of(context).pushNamed(
                          '/unknown',
                          arguments: course,
                        ),
                      ),
                    ],
                    if (course.numberOfExams > 0) ...[
                      const Gap(10),
                      CourseInfoTile(
                        image: const Icon(IconlyLight.paper),
                        title: '${course.numberOfVideos} Exam(s)',
                        subTitle: 'Take our exams for ${course.title}',
                        onPressed: () => Navigator.of(context).pushNamed(
                          '/unknown',
                          arguments: course,
                        ),
                      ),
                    ],
                    if (course.numberOfMaterials > 0) ...[
                      const Gap(10),
                      CourseInfoTile(
                        image: const Icon(IconlyLight.document),
                        title: '${course.numberOfVideos} Materials(s)',
                        subTitle: 'Access to over '
                            '${course.numberOfMaterials.estimate} '
                            'material for ${course.title}',
                        onPressed: () => Navigator.of(context).pushNamed(
                          '/unknown',
                          arguments: course,
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
