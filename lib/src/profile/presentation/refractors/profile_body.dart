import 'package:fca_education_app/%20core/common/app/providers/user_providers.dart';
import 'package:fca_education_app/%20core/res/colors.dart';
import 'package:fca_education_app/src/profile/presentation/widgets/user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, provider, __) {
        final user = provider.user;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: UserInfoCard(
                    icon: const Icon(
                      IconlyLight.document,
                      size: 24,
                      color: Color(
                        0xFF767DFF,
                      ),
                    ),
                    infoThemeColor: Colours.physicsTileColour,
                    infoTitle: 'Courses',
                    infoValue: user!.enrolledCourses.length.toString(),
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: UserInfoCard(
                    icon: const Icon(
                      Icons.scoreboard,
                      size: 24,
                      color: Color(
                        0xFF767DFF,
                      ),
                    ),
                    infoThemeColor: Colours.languageTileColour,
                    infoTitle: 'Score',
                    infoValue: user.points.toString(),
                  ),
                ),
              ],
            ),
            const Gap(20),
            Row(
              children: [
                Expanded(
                  child: UserInfoCard(
                    icon: const Icon(
                      IconlyLight.user,
                      size: 24,
                      color: Color(0xFF56AEFF),
                    ),
                    infoThemeColor: Colours.biologyTileColour,
                    infoTitle: 'Followers',
                    infoValue: user.followers.length.toString(),
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: UserInfoCard(
                    icon: const Icon(
                      IconlyLight.user,
                      size: 24,
                      color: Color(0xFFFF84AA),
                    ),
                    infoThemeColor: Colours.chemistryTileColour,
                    infoTitle: 'Following',
                    infoValue: user.following.length.toString(),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
