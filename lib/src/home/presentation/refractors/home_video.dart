import 'package:fca_education_app/core/%20services/injection_container.dart';
import 'package:fca_education_app/core/common/views/loading_view.dart';
import 'package:fca_education_app/core/common/widgets/not_found_text.dart';
import 'package:fca_education_app/core/extensions/context_extension.dart';
import 'package:fca_education_app/core/utils/core_utils.dart';
import 'package:fca_education_app/src/course/features/videos/presentation/cubit/video_cubit.dart';
import 'package:fca_education_app/src/home/presentation/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeVideos extends StatefulWidget {
  const HomeVideos({super.key});

  @override
  State<HomeVideos> createState() => _HomeVideosState();
}

class _HomeVideosState extends State<HomeVideos> {
  void getVideos() {
    context.read<VideoCubit>().getVideos(context.courseOfTheDay.id);
  }

  @override
  void initState() {
    super.initState();
    getVideos();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoCubit, VideoState>(
      listener: (context, state) {
        if (state is VideoError) {
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is LoadingVideos) {
          return const Loadingview();
        } else if ((state is VideosLoaded && state.videos.isEmpty) ||
            state is VideoError) {
          return NotFoundText(
            text: 'No Videos found for ${context.courseOfTheDay.title}',
          );
        } else if (state is VideosLoaded) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                sectionTitle: '${context.courseOfTheDay.title} videos',
                seeAll: state.videos.length > 4,
                onPreesed: () => context.push(
                  BlocProvider(
                    create: (_) => sl<VideoCubit>(),
                    //  child: CourseVideoView(),
                  ),
                ),
              ),
              const Gap(20),
              // ignore: unused_local_variable
              for (final video in state.videos.take(5)) const Placeholder(),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
