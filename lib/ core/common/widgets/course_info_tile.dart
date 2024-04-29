import 'package:fca_education_app/%20core/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class CourseInfoTile extends StatelessWidget {
  const CourseInfoTile({
    required this.onPressed,
    required this.image,
    required this.title,
    required this.subTitle,
    super.key,
  });

  final VoidCallback onPressed;
  final Widget image;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colours.neutralTextColour),
              borderRadius: BorderRadius.circular(10),
            ),
            width: 44,
            height: 44,
            child: image,
          ),
          const Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                subTitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colours.neutralTextColour,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
