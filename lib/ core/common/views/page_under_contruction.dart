import 'package:fca_education_app/%20core/res/media_res.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ColoredBox(
          color: Colors.white,
          child: Center(
            child: LottieBuilder.asset(
              MediaResources.pageUnderContruction,
            ),
          ),
        ),
      ),
    );
  }
}
