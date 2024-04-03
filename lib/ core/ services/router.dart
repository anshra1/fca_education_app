import 'package:fca_education_app/%20core/%20services/injection.dart';
import 'package:fca_education_app/%20core/common/views/page_under_contruction.dart';
import 'package:fca_education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:fca_education_app/src/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OnBoardingScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (context) => sl<OnBoardingCubit>(),
          child: const OnBoardingScreen(),
        ),
        settings: settings,
      );

    default:
      return _pageBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder<dynamic>(
    settings: settings,
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) =>
        page(context),
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) =>
        FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}
