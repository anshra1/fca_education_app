import 'package:fca_education_app/core/common/widgets/course_picker.dart';
import 'package:fca_education_app/core/common/widgets/info_field.dart';
import 'package:fca_education_app/core/common/widgets/reactive_button.dart';
import 'package:fca_education_app/core/common/widgets/video_tile.dart';
import 'package:fca_education_app/core/enum/notification_enum.dart';
import 'package:fca_education_app/core/extensions/string_extension.dart';
import 'package:fca_education_app/core/utils/core_utils.dart';
import 'package:fca_education_app/src/course/domain/entites/entites.dart';
import 'package:fca_education_app/src/course/features/videos/data/models/video_model.dart';
import 'package:fca_education_app/src/course/features/videos/domain/entity/video.dart';
import 'package:fca_education_app/src/course/features/videos/presentation/cubit/video_cubit.dart';
import 'package:fca_education_app/src/course/features/videos/presentation/utils/video_utils.dart';
import 'package:fca_education_app/src/notification/presentation/widgets/notification_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:gap/gap.dart';

class AddVideoView extends StatefulWidget {
  const AddVideoView({super.key});

  static const routeName = '/add-video';

  @override
  State<AddVideoView> createState() => _AddVideoViewState();
}

class _AddVideoViewState extends State<AddVideoView> {
  final urlController = TextEditingController();
  final authController = TextEditingController(text: 'Ansh Raj');
  final titleController = TextEditingController();
  final courseController = TextEditingController();
  final courseNotifier = ValueNotifier<Course?>(null);

  final formKey = GlobalKey<FormState>();
  final authorFocusNode = FocusNode();
  final titleFocusNode = FocusNode();
  final urlFocusNode = FocusNode();
  bool loading = false;

  Video? video;
  PreviewData? previewData;

  bool get isYoutube => urlController.text.trim().isYoutubeVideo;

  bool getMoreDetails = false;

  bool thumbNailIsFile = false;

  bool showingDialog = false;

  void reset() {
    setState(() {
      urlController.clear();
      authController.text = 'Ansh Raj';
      titleController.clear();
      getMoreDetails = false;
      loading = false;
      video = null;
      previewData = null;
    });
  }

  Future<void> fetchVideo() async {
    if (urlController.text.trim().isEmpty) return;
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      getMoreDetails = false;
      loading = false;
      thumbNailIsFile = false;
      video = null;
      previewData = null;
    });

    setState(() {
      loading = true;
    });

    if (isYoutube) {
      video = await VideoUtils.getVideoFromYT(
        context,
        url: urlController.text.trim(),
      ) as VideoModel?;

      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    urlController.addListener(() {
      if (urlController.text.isEmpty) reset();
    });

    authController.addListener(() {
      video = video?.copyWith(tutor: authController.text.trim());
    });

    titleController.addListener(() {
      video = video?.copyWith(title: titleController.text.trim());
    });
  }

  @override
  void dispose() {
    super.dispose();
    urlController.dispose();
    authController.dispose();
    titleController.dispose();
    courseNotifier.dispose();
    courseController.dispose();
    urlFocusNode.dispose();
    authorFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationWrapper(
      onNotificationSent: () {
        if (loading) {
          Navigator.of(context).pop();
        }
        Navigator.of(context).pop();
      },
      child: BlocListener<VideoCubit, VideoState>(
        listener: (context, state) {
          if (showingDialog == true) {
            Navigator.pop(context);
            showingDialog = false;
          }

          if (state is AddingVideo) {
            CoreUtils.showLoadingDialog(context);
            showingDialog = true;
          } else if (state is VideoError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is VideoAdded) {
            CoreUtils.showSnackBar(context, 'Video Added Successfully');
            CoreUtils.sendNotification(
              context,
              title: 'New ${courseNotifier.value!.title} video',
              body: 'A new video has been added for '
                  '${courseNotifier.value!.title}',
              category: NotificationCatgory.VIDEO,
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Add Video'),
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            shrinkWrap: true,
            children: [
              Form(
                key: formKey,
                child: CoursePicker(
                  controller: courseController,
                  notifier: courseNotifier,
                ),
              ),
              const Gap(20),
              InfoField(
                controller: urlController,
                hintText: 'Enter Video URL',
                onEditingComplete: fetchVideo,
                focusNode: urlFocusNode,
                onTapOutside: (_) => urlFocusNode.unfocus(),
                autoFocus: true,
                keyboardType: TextInputType.url,
              ),
              ListenableBuilder(
                listenable: urlController,
                builder: (context, child) {
                  return Column(
                    children: [
                      if (urlController.text.trim().isNotEmpty) ...[
                        const Gap(20),
                        ElevatedButton(
                          onPressed: fetchVideo,
                          child: const Text('Fetch Video'),
                        ),
                      ],
                    ],
                  );
                },
              ),
              if (loading && !isYoutube)
                LinkPreview(
                  onPreviewDataFetched: (data) async {
                    setState(() {
                      thumbNailIsFile = false;
                      video = VideoModel.empty().copyWith(
                        thumbnail: data.image?.url,
                        videoURL: urlController.text.trim(),
                        title: data.title ?? 'No Title',
                      );

                      if (data.image?.url != null) loading = false;
                      getMoreDetails = true;
                      titleController.text = data.title ?? '';

                      loading = false;
                    });
                  },
                  previewData: previewData,
                  text: '',
                  width: 0,
                ),
              if (video != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: VideoTile(
                    video!,
                    isFile: thumbNailIsFile,
                    uploadTimePrefix: '-',
                  ),
                ),
              if (getMoreDetails) ...[
                InfoField(
                  controller: authController,
                  keyboardType: TextInputType.name,
                  autoFocus: true,
                  focusNode: authorFocusNode,
                  labelText: 'Tutor Name',
                  onEditingComplete: () {
                    setState(() {});
                    titleFocusNode.requestFocus();
                  },
                ),
                InfoField(
                  controller: titleController,
                  focusNode: titleFocusNode,
                  labelText: 'Video Tile',
                  onEditingComplete: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    setState(() {});
                  },
                ),
              ],
              const Gap(20),
              Center(
                child: ReactiveButtton(
                  loading: loading,
                  disabled: video == null,
                  text: 'Submit',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (courseNotifier.value == null) {
                        CoreUtils.showSnackBar(context, 'Please pick a course');
                        return;
                      }

                      if (courseNotifier.value != null &&
                          video != null &&
                          video!.tutor == null &&
                          authController.text.trim().isNotEmpty) {
                        video =
                            video!.copyWith(tutor: authController.text.trim());
                      }

                      if (video != null &&
                          video!.title != null && video!.title!.isNotEmpty &&
                          video!.tutor != null) {
                        video = video?.copyWith(
                          thumbnailIsFile: thumbNailIsFile,
                          courseId: courseNotifier.value!.id,
                          uploadData: DateTime.now(),
                        );

                        context.read<VideoCubit>().addVideo(video!);
                      } else {
                        CoreUtils.showSnackBar(
                          context,
                          'Please fill all fields',
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
