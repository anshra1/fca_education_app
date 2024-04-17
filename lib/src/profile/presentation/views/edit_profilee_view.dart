import 'dart:io';

import 'package:fca_education_app/%20core/extensions/context_extension.dart';
import 'package:fca_education_app/%20core/common/app/user_data_bloc/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditPrifleView extends StatefulWidget {
  const EditPrifleView({super.key});

  @override
  State<EditPrifleView> createState() => _EditPrifleViewState();
}

class _EditPrifleViewState extends State<EditPrifleView> {
  final fullNamController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final bioController = TextEditingController();
  final oldPasswordController = TextEditingController();

  File? pickedImage;

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
      });
    }
  }

  bool get nameChanged =>
      context.currentUser?.fullName.trim() != fullNamController.text.trim();

  // bool get name =>
  //     context.read<UserBloc>().localUserModel.fullName.trim() !=
  //     fullNamController.text.trim();  // using bloc

  bool get emailChanged => emailController.text.trim().isNotEmpty;

  bool get passwordChanged => passwordController.text.trim().isNotEmpty;

  bool get bioChangeed =>
      context.currentUser?.bio?.trim() != bioController.text.trim();

  bool get imageChanged => pickedImage != null;

  bool get nothingChanged =>
      !nameChanged &&
      !emailChanged &&
      !passwordChanged &&
      !bioChangeed &&
      !imageChanged;

  @override
  void initState() {
    fullNamController.text = context.currentUser!.fullName.trim();
    bioController.text = context.currentUser!.bio?.trim() ?? '';
    super.initState();
  }

  @override
  void dispose() {
    fullNamController.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    oldPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
