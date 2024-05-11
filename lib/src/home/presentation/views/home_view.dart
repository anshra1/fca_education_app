import 'package:fca_education_app/core/common/widgets/gradient_background.dart';
import 'package:fca_education_app/src/home/presentation/refractors/home_body.dart';
import 'package:fca_education_app/src/home/presentation/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(),
      body: GradientBackground(
        child: HomeBody(),
      ),
    );
  }
}
