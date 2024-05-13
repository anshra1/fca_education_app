import 'package:fca_education_app/core/common/widgets/course_picker.dart';
import 'package:fca_education_app/core/common/widgets/info_field.dart';
import 'package:fca_education_app/core/common/widgets/video_tile.dart';
import 'package:fca_education_app/core/extensions/string_extension.dart';
import 'package:fca_education_app/src/course/domain/entites/entites.dart';
import 'package:fca_education_app/src/course/features/videos/data/models/video_model.dart';
import 'package:fca_education_app/src/course/features/videos/domain/entity/video.dart';
import 'package:fca_education_app/src/course/features/videos/presentation/utils/video_utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:flutter_link_previewer/flutter_link_previewer.dart';

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
    return Scaffold(
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
              controller: titleController,
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
                });
              },
              previewData: previewData,
              text: '',
              width: 0,
            ),
          if (video != null) VideoTile(video!),
        ],
      ),
    );
  }
}
