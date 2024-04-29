import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({
    required this.icon,
    required this.infoThemeColor,
    required this.infoTitle,
    required this.infoValue,
    super.key,
  });

  final Color infoThemeColor;
  final Widget icon;
  final String infoTitle;
  final String infoValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
          width: 0.7,
      ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: infoThemeColor,
                child: icon,
              ),
              const Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(infoTitle),
                  Text(
                    infoValue,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
