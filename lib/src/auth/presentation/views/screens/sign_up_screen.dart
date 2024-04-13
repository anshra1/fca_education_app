import 'package:fca_education_app/%20core/common/app/providers/user_providers.dart';
import 'package:fca_education_app/%20core/common/widgets/gradient_background.dart';
import 'package:fca_education_app/%20core/common/widgets/rounded_button.dart';
import 'package:fca_education_app/%20core/res/fonts.dart';
import 'package:fca_education_app/%20core/utils/core_utils.dart';
import 'package:fca_education_app/src/auth/datasources/models/user_model.dart';
import 'package:fca_education_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:fca_education_app/src/auth/presentation/views/screens/sign_in_screen.dart';
import 'package:fca_education_app/src/auth/presentation/views/widgets/sign_up_form.dart';
import 'package:fca_education_app/src/dashboard/presentation/views/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const routeName = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final fullNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is AuthSignUpState) {
            context.read<AuthBloc>().add(
                  SignInEvent(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  ),
                );
          } else if (state is AuthSignInState) {
            context
                .read<UserProvider>()
                .initUser(state.localUser as LocalUserModel);

            Navigator.pushReplacementNamed(context, DashBoard.routeName);
          }
        },
        builder: (context, state) {
          return GradientBackground(
            child: SafeArea(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const Text(
                    'Easy to learn,discover more skills',
                    style: TextStyle(
                      fontFamily: Fonts.aeonik,
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  ),
                  const Gap(10),
                  const Text(
                    'Sign Up to your Accont',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const Gap(10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          SignInScreen.routeName,
                        );
                      },
                      child: const Text('Already have an account?'),
                    ),
                  ),
                  const Gap(10),
                  SignUpForm(
                    emailController: emailController,
                    passwordController: passwordController,
                    formKey: formKey,
                    nameController: fullNameController,
                  ),
                  const Gap(20),
                  if (state is AuthLoadingState)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else
                    RoundedButton(
                      label: 'Sign Up',
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        FirebaseAuth.instance.currentUser?.reload();
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                SignUpEvent(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  name: fullNameController.text.trim(),
                                ),
                              );
                        }
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
