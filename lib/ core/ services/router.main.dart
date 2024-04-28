part of 'router.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      final prefs = sl<SharedPreferences>();
      return _pageBuilder(
        (context) {
          if (prefs.getBool(kFirstTimer) ?? true) {
            return BlocProvider(
              create: (context) => sl<OnBoardingCubit>(),
              child: const OnBoardingScreen(),
            );
          } else if (sl<FirebaseAuth>().currentUser != null) {
            final user = sl<FirebaseAuth>().currentUser!;

            final localUser = LocalUserModel(
              uid: user.uid,
              email: user.email ?? '',
              points: 0,
              fullName: user.displayName ?? '',
              profilePic: user.photoURL ?? '',
            );

            context.userProvider.initUser(localUser);

            return const DashBoard();
          } else {
            return BlocProvider(
              create: (_) => sl<AuthBloc>(),
              child: const SignInScreen(),
            );
          }
        },
        settings: settings,
      );

    case SignInScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignInScreen(),
        ),
        settings: settings,
      );

    case SignUpScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignUpScreen(),
        ),
        settings: settings,
      );

    case DashBoard.routeName:
      return _pageBuilder(
        (p0) => const DashBoard(),
        settings: settings,
      );

    case '/forgot-password':
      return _pageBuilder(
        (p0) => const fui.ForgotPasswordScreen(),
        settings: settings,
      );

    case CourseDetailView.routeName:
      return _pageBuilder(
        (p0) =>  CourseDetailView(course: settings.arguments! as Course),
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
