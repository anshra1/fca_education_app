import 'dart:convert';
import 'dart:io';
import 'package:fca_education_app/core/common/app/providers/tab_navigator.dart';
import 'package:fca_education_app/core/common/widgets/gradient_background.dart';
import 'package:fca_education_app/core/common/widgets/nested_back_button.dart';
import 'package:fca_education_app/core/enum/user_data.dart';
import 'package:fca_education_app/core/extensions/context_extension.dart';
import 'package:fca_education_app/core/res/media_res.dart';
import 'package:fca_education_app/core/utils/core_utils.dart';
import 'package:fca_education_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:fca_education_app/src/profile/presentation/widgets/edit_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class EditPrifleView extends HookWidget {
  const EditPrifleView({super.key});

  @override
  Widget build(BuildContext context) {
    final fullNamController =
        useTextEditingController(text: context.currentUser!.fullName.trim());

    final emailController =
        useTextEditingController(text: context.currentUser!.bio?.trim());
    final passwordController = useTextEditingController();
    final bioController = useTextEditingController();
    final oldPasswordController = useTextEditingController();
    final pickedImage = useState<File?>(null);

    debugPrint('build');

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UserUpdateState) {
          CoreUtils.showSnackBar(context, 'Profile Updated Sucessfully');
          //   context.pop();  same as below using extension
          context.read<TabNavigator>().pop();
        } else if (state is AuthErrorState) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is AuthLoadingState) {
          const CircularProgressIndicator.adaptive();
        }
      },
      builder: (context, state) {
        return Scaffold(
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
              DoneButton(
                fullNamController: fullNamController,
                emailController: emailController,
                passwordController: passwordController,
                bioController: bioController,
                pickedImage: pickedImage,
                oldPasswordController: oldPasswordController,
                state: state,
              ),
            ],
          ),
          body: GradientBackground(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                ImagePick(
                  imageValue: (value) {
                    pickedImage.value = value;
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

class DoneButton extends StatelessWidget {
  const DoneButton({
    required this.fullNamController,
    required this.emailController,
    required this.passwordController,
    required this.bioController,
    required this.pickedImage,
    required this.oldPasswordController,
    required this.state,
    super.key,
  });

  final TextEditingController fullNamController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController bioController;
  final ValueNotifier<File?> pickedImage;
  final TextEditingController oldPasswordController;
  final dynamic state;

  @override
  Widget build(BuildContext context) {
    return HookBuilder(
      builder: (context) {
        final done = useState(false);

        final nameChanged = context.currentUser?.fullName.trim() !=
            fullNamController.text.trim();

        final emailChanged = emailController.text.trim().isNotEmpty;

        final passwordChanged = passwordController.text.trim().isNotEmpty;

        final bioChangeed =
            context.currentUser?.bio?.trim() != bioController.text.trim();

        final imageChanged = pickedImage.value != null;

        fullNamController.addListener(() {
          nameChanged ? done.value = true : done.value = false;
        });

        emailController.addListener(() {
          emailChanged ? done.value = true : done.value = false;
        });

        passwordController.addListener(() {
          passwordChanged ? done.value = true : done.value = false;
        });

        bioController.addListener(() {
          bioChangeed ? done.value = true : done.value = false;
        });

        pickedImage.addListener(() {
          pickedImage.value != null ? done.value = true : done.value = false;
        });

        debugPrint('HookBuilder');
        return TextButton(
          onPressed: () {
            if (done.value) context.pop();
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
                  userData: pickedImage.value,
                ),
              );
            }
          },
          child: state is AuthLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: done.value ? Colors.grey : Colors.blueAccent,
                  ),
                ),
        );
      },
    );
  }
}

class ImagePick extends HookWidget {
  const ImagePick({required this.imageValue, super.key});

  final ValueChanged<File?> imageValue;

  @override
  Widget build(BuildContext context) {
    final image = useState<File?>(null);
    final user = context.currentUser!;
    final userImage = user.profilePic == null || user.profilePic!.isEmpty
        ? null
        : user.profilePic;
    return CircleAvatar(
      radius: 50,
      backgroundImage: image.value != null
          ? FileImage(
              image.value!,
            )
          : userImage != null
              ? NetworkImage(userImage)
              : const AssetImage(MediaResources.physicsIcon) as ImageProvider,
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
            onPressed: () async {
              final pickImage =
                  await ImagePicker().pickImage(source: ImageSource.gallery);

              if (pickImage != null) {
                image.value = File(pickImage.path);
              }

              imageValue(image.value);
            },
            icon: Icon(
              image.value != null || user.profilePic != null
                  ? Icons.edit
                  : Icons.add_a_photo,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
