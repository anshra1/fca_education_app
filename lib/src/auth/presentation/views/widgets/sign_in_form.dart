import 'package:fca_education_app/%20core/common/widgets/i_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
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
              icon: Icon(
                obsecureText ? IconlyLight.show : IconlyLight.hide,
              ),
              onPressed: () {
                setState(() {
                  obsecureText = !obsecureText;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
