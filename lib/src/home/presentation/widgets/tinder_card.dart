import 'package:fca_education_app/%20core/common/app/providers/course_of_the_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';

class TinderCard extends StatelessWidget {
  const TinderCard({
    required this.isFirst,
    required this.color,
    super.key,
  });

  final bool isFirst;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: 137,
            padding: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              gradient: isFirst
                  ? const LinearGradient(
                      colors: [
                        Color(0xFF8E96FF),
                        Color(0xFFA06AF9),
                      ],
                    )
                  : null,
              color: color,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.5),
                  offset: const Offset(0, 5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: isFirst
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        // ignore: lines_longer_than_80_chars
                        '${context.read<CourseOfTheDayNotifier>().courseOfTheDay?.title ?? 'Chemistry'} final\nexams',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      const Row(
                        children: [
                          Icon(
                            IconlyLight.notification,
                            color: Colors.white,
                          ),
                          Gap(8),
                          Text(
                            '45 Minutes',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : null,
          ),
          
        ],
      ),
    );
  }
}
