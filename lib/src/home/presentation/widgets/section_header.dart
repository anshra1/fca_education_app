import 'package:fca_education_app/core/res/colors.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.sectionTitle,
    required this.seeAll,
    required this.onPreesed,
    super.key,
  });

  final String sectionTitle;
  final bool seeAll;
  final VoidCallback onPreesed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          sectionTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (seeAll)
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              splashFactory: NoSplash.splashFactory,
            ),
            onPressed: onPreesed,
            child: const Text(
              'See All',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colours.primaryColour,
              ),
            ),
          ),
      ],
    );
  }
}
