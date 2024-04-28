import 'package:fca_education_app/src/course/domain/entites/entites.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CourseTile extends StatelessWidget {
  const CourseTile({
    required this.course,
    this.voidCallback,
    super.key,
  });

  final Course course;
  final VoidCallback? voidCallback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: voidCallback,
      child: SizedBox(
        width: 54,
        child: Column(
          children: [
            SizedBox(
              height: 54,
              width: 54,
              child: Image.network(
                course.image!,
                height: 32,
                width: 32,
                fit: BoxFit.cover,
              ),
            ),
            const Gap(5),
            Text(
              course.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
