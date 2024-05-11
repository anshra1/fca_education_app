import 'dart:io';

import 'package:fca_education_app/core/%20services/injection_container.dart';
import 'package:fca_education_app/core/common/widgets/title_input_field.dart';
import 'package:fca_education_app/core/enum/notification_enum.dart';
import 'package:fca_education_app/core/utils/constants.dart';
import 'package:fca_education_app/core/utils/core_utils.dart';
import 'package:fca_education_app/src/course/data/model/course_model.dart';
import 'package:fca_education_app/src/course/presentation/cubit/course_cubit.dart';
import 'package:fca_education_app/src/notification/data/model/notification_model.dart';
import 'package:fca_education_app/src/notification/presentation/cubit/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AddCourseSheet extends StatefulWidget {
  const AddCourseSheet({super.key});

  @override
  State<AddCourseSheet> createState() => _AddCourseSheetState();
}

class _AddCourseSheetState extends State<AddCourseSheet> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  File? image;

  bool isFile = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    imageController.addListener(() {
      if (isFile && imageController.text.trim().isEmpty) {
        image = null;
        isFile = false;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    imageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationCubit, NotificationState>(
      listener: (BuildContext context, state) {
        if (state is NotificationSent) {
          if (loading) {
            Navigator.of(context).pop();
          }
          Navigator.of(context).pop();
        }
      },
      child: BlocListener<CourseCubit, CourseState>(
        listener: (context, state) async {
          if (state is CourseErrorState) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is AdddingCoursesState) {
            loading = true;
            CoreUtils.showLoadingDialog(context);
          } else if (state is CourseAddedState) {
            if (loading) {
              loading = false;
              Navigator.pop(context);
            }
            CoreUtils.showSnackBar(context, 'Course Added Sucessfully');
            Navigator.pop(context);
            CoreUtils.showLoadingDialog(context);

            await sl<NotificationCubit>().sendNotification(
              NotificationModel.empty().copyWith(
                title: 'New Course (${titleController.text.trim()})',
                body: 'A new course has been added',
                catgory: NotificationCatgory.COURSE,
              ),
            );
          }
        },
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Form(
              key: formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  const Text(
                    'Add Course',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Gap(20),
                  TiltledInputField(
                    controller: titleController,
                    title: 'Course Title',
                  ),
                  const Gap(10),
                  TiltledInputField(
                    controller: descriptionController,
                    title: 'Description',
                    required: false,
                  ),
                  TiltledInputField(
                    controller: imageController,
                    title: 'Course Image',
                    required: false,
                    hintText: 'Enter image URL or pick from gallery',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        final image = await CoreUtils.pickImage();
                        if (image != null) {
                          isFile = true;
                          this.image = image;
                          final imageName = image.path.split('/').last;
                          imageController.text = imageName;
                        }
                      },
                      icon: const Icon(Icons.add_photo_alternate_outlined),
                    ),
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              final now = DateTime.now();
                              final course = CourseModel.empty().copyWith(
                                title: titleController.text.trim(),
                                description: descriptionController.text.trim(),
                                image: imageController.text.trim().isEmpty
                                    ? kDefaultAvtar
                                    : isFile
                                        ? image!.path
                                        : imageController.text.trim(),
                                createdAt: now,
                                updatedAt: now,
                                imageIsFile: isFile,
                              );
                              context.read<CourseCubit>().addCourse(course);
                            }
                          },
                          child: const Text('Add'),
                        ),
                      ),
                      const Gap(20),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
