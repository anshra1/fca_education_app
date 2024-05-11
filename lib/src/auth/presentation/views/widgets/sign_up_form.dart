import 'package:fca_education_app/core/common/widgets/i_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.nameController,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignUpForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignUpForm> {
  bool obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          IField(
            controller: widget.nameController,
            hintText: 'Full Name',
            keyboardType: TextInputType.name,
          ),
          const Gap(25),
          IField(
            controller: widget.emailController,
            hintText: 'Email Address',
            keyboardType: TextInputType.emailAddress,
          ),
          const Gap(25),
          IField(
            controller: widget.passwordController,
            hintText: 'Password',
            obsecureText: obsecureText,
            keyboardType: TextInputType.visiblePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obsecureText = !obsecureText;
                });
              },
              icon: Icon(obsecureText ? IconlyLight.show : IconlyLight.hide),
            ),
          ),
          const Gap(25),
          IField(
            controller: widget.passwordController,
            hintText: 'Confirm Password',
            obsecureText: obsecureText,
            keyboardType: TextInputType.visiblePassword,
            suffixIcon: IconButton(
              icon: Icon(
                obsecureText ? IconlyLight.show : IconlyLight.hide,
              ),
              onPressed: () {
                setState(() {
                  obsecureText = !obsecureText;
                });
              },
            ),
            overrideValidator: true,
            validator: (value) {
              if (value != widget.passwordController.text) {
                return 'Password do not match';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
