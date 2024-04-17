import 'package:fca_education_app/%20core/common/widgets/gradient_background.dart';
import 'package:fca_education_app/%20core/utils/constants.dart';
import 'package:fca_education_app/src/profile/presentation/refractors/profile_header.dart';
import 'package:fca_education_app/src/profile/presentation/widgets/profile_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
   //     extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: const ProfileAppBar(),
        body: GradientBackground(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children:  const [
              ProfileHeader(),
              
            ],
          ),
        ),
      ),
    );
  }
}
