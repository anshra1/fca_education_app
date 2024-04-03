import 'package:fca_education_app/%20core/common/views/loading_view.dart';
import 'package:fca_education_app/%20core/common/widgets/gradient_background.dart';
import 'package:fca_education_app/%20core/res/colors.dart';
import 'package:fca_education_app/src/on_boarding/domain/entites/page_content.dart';
import 'package:fca_education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:fca_education_app/src/on_boarding/presentation/widgets/on_boarding_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static const routeName = '/';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OnBoardingCubit>().checkIfUserIsFirstTimer();
  }

  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<OnBoardingCubit, OnBoardingState>(
        listener: (context, state) {
          if (state is OnBoardingStatus && !state.isFirstTimer) {
            Navigator.pushReplacementNamed(
              context,
              '/home',
            );
          } else if (state is UserCached) {

          }
        },
        builder: (context, state) {
          if (state is CheckIfUserIsFirstTimer || state is CachingFirstTimer) {
            return const Loadingview();
          }
          return GradientBackground(
            child: Stack(
              children: [
                PageView(
                  children: const [
                    OnBoardingBody(pageContent: PageContent.first()),
                    OnBoardingBody(pageContent: PageContent.second()),
                    OnBoardingBody(pageContent: PageContent.third()),
                  ],
                ),
                Align(
                  alignment: const Alignment(0, .04),
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    onDotClicked: (index) {
                      pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.bounceInOut,
                      );
                    },
                    effect: const WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      dotColor: Colours.primaryColour,
                      activeDotColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
