import 'package:fca_education_app/core/common/widgets/course_picker.dart';
import 'package:fca_education_app/core/extensions/string_extension.dart';
import 'package:fca_education_app/src/course/domain/entites/entites.dart';
import 'package:flutter/material.dart';

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

  bool get isYoutube => urlController.text.trim().isYoutubeVideo;

  bool getMoreDetails = false;

  bool thumbNailIsFile = false;

  void reset() {
    setState(() {
      urlController.clear();
      authController.text = 'Ansh Raj';
      titleController.clear();
      getMoreDetails = false;
    });
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
          CoursePicker(
            controller: titleController,
            notifier: courseNotifier,
          ),
        ],
      ),
    );
  }
}
