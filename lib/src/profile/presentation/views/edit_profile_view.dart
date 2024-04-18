import 'dart:convert';
import 'dart:io';
import 'package:fca_education_app/%20core/common/app/providers/tab_navigator.dart';
import 'package:fca_education_app/%20core/common/widgets/gradient_background.dart';
import 'package:fca_education_app/%20core/common/widgets/nested_back_button.dart';
import 'package:fca_education_app/%20core/enum/user_data.dart';
import 'package:fca_education_app/%20core/extensions/context_extension.dart';
import 'package:fca_education_app/%20core/res/media_res.dart';
import 'package:fca_education_app/%20core/utils/core_utils.dart';
import 'package:fca_education_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:fca_education_app/src/profile/presentation/widgets/edit_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
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
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UserUpdateState) {
          CoreUtils.showSnackBar(context, 'Profile Updated Sucessfully');
          //   context.pop();  same as below using extension
          context.read<TabNavigator>().pop();
        } else if (state is AuthErrorState) {
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          // extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: const NestedBackButton(),
            title: const Text(
              'Edit Profile',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (nameChanged) context.pop();
                  final bloc = context.read<AuthBloc>();

                  if (passwordChanged) {
                    if (oldPasswordController.text.isEmpty) {
                      CoreUtils.showSnackBar(
                        context,
                        'Please enter your old Password',
                      );
                    }
                  }

                  bloc.add(
                    UpdateUserEvent(
                      action: UpdateUserAction.password,
                      userData: jsonEncode({
                        'oldPassword': oldPasswordController.text.trim(),
                        'newPassword': passwordController.text.trim(),
                      }),
                    ),
                  );

                  if (nameChanged) {
                    bloc.add(
                      UpdateUserEvent(
                        action: UpdateUserAction.displyName,
                        userData: fullNamController.text.trim(),
                      ),
                    );
                  }

                  if (emailChanged) {
                    bloc.add(
                      UpdateUserEvent(
                        action: UpdateUserAction.email,
                        userData: emailController.text.trim(),
                      ),
                    );
                  }

                  if (bioChangeed) {
                    bloc.add(
                      UpdateUserEvent(
                        action: UpdateUserAction.bio,
                        userData: bioController.text.trim(),
                      ),
                    );
                  }

                  if (imageChanged) {
                    bloc.add(
                      UpdateUserEvent(
                        action: UpdateUserAction.profilePic,
                        userData: pickedImage,
                      ),
                    );
                  }
                },
                child: state is AuthLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : StatefulBuilder(
                        builder: (context, refresh) {
                          fullNamController.addListener(() => refresh(() {}));
                          emailController.addListener(() => refresh(() {}));
                          passwordController.addListener(() => refresh(() {}));
                          bioController.addListener(() => refresh(() {}));
                          return Text(
                            'Done',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: nothingChanged
                                  ? Colors.grey
                                  : Colors.blueAccent,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
          body: GradientBackground(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                Builder(
                  builder: (context) {
                    final user = context.currentUser!;
                    final userImage =
                        user.profilePic == null || user.profilePic!.isEmpty
                            ? null
                            : user.profilePic;
                    return CircleAvatar(
                      radius: 50,
                      backgroundImage: pickedImage != null
                          ? FileImage(
                              pickedImage!,
                            )
                          : userImage != null
                              ? NetworkImage(userImage)
                              : const AssetImage(MediaResources.atom)
                                  as ImageProvider,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(.5),
                            ),
                          ),
                          IconButton(
                            onPressed: pickImage,
                            icon: Icon(
                              pickedImage != null || user.profilePic != null
                                  ? Icons.edit
                                  : Icons.add_a_photo,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Gap(10),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    'We recommend an image of at least 400x400',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF777E90),
                    ),
                  ),
                ),
                const Gap(30),
                EditProfileForm(
                  fullNamController: fullNamController,
                  emailController: emailController,
                  passwordController: passwordController,
                  bioController: bioController,
                  oldPasswordController: oldPasswordController,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
