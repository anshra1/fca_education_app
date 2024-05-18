import 'package:fca_education_app/core/%20services/injection_container.dart';
import 'package:fca_education_app/core/common/app/providers/user_providers.dart';
import 'package:fca_education_app/core/extensions/context_extension.dart';
import 'package:fca_education_app/core/res/colors.dart';
import 'package:fca_education_app/src/course/features/exams/presentation/app/cubit/exam_cubit.dart';
import 'package:fca_education_app/src/course/features/exams/presentation/views/add_exam_view.dart';
import 'package:fca_education_app/src/course/features/materials/presentation/views/add_material_view.dart';
import 'package:fca_education_app/src/course/features/videos/presentation/views/add_video_view.dart';
import 'package:fca_education_app/src/course/presentation/cubit/course_cubit.dart';
import 'package:fca_education_app/src/course/presentation/views/add_course_sheet.dart';
import 'package:fca_education_app/src/notification/presentation/cubit/notification_cubit.dart';
import 'package:fca_education_app/src/profile/presentation/widgets/admin_button.dart';
import 'package:fca_education_app/src/profile/presentation/widgets/user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            const Gap(25),
            if (context.currentUser!.isAdmin) ...[
              AdminButton(
                label: 'Add Course',
                icon: IconlyLight.paper_upload,
                onPressed: () {
                  showModalBottomSheet<void>(
                    backgroundColor: Colors.white,
                    isScrollControlled: true,
                    elevation: 0,
                    useSafeArea: true,
                    context: context,
                    builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider(create: (_) => sl<CourseCubit>()),
                        BlocProvider(create: (_) => sl<NotificationCubit>()),
                        BlocProvider(create: (_) => sl<ExamCubit>()),
                      ],
                      child: const AddCourseSheet(),
                    ),
                  );
                },
              ),
              AdminButton(
                label: 'Add Video',
                icon: IconlyLight.video,
                onPressed: () {
                  Navigator.pushNamed(context, AddVideoView.routeName);
                },
              ),
              AdminButton(
                label: 'Add Materials',
                icon: IconlyLight.paper_download,
                onPressed: () {
                  Navigator.pushNamed(context, AddMaterialsView.routeName);
                },
              ),
              AdminButton(
                label: 'Add Exams',
                icon: IconlyLight.document,
                onPressed: () {
                  Navigator.pushNamed(context, AddExamView.routeName);
                },
              ),
            ],
          ],
        );
      },
    );
  }
}
