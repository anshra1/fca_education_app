import 'package:fca_education_app/core/common/widgets/time_text.dart';
import 'package:fca_education_app/core/res/colors.dart';
import 'package:flutter/material.dart';

class TimeTile extends StatelessWidget {
  const TimeTile(this.time, {super.key, this.prefixText});

  final DateTime time;
  final String? prefixText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colours.primaryColour,
        borderRadius: BorderRadius.circular(90),
      ),
      child: TimeText(
        time,
        prefixText: prefixText,
        maxLines: 2,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
