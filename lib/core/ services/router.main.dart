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

    // case '/forgot-password':
    //   return _pageBuilder(
    //     (p0) => const fui.ForgotPasswordScreen(),
    //     settings: settings,
    //   );

    case CourseDetailView.routeName:
      return _pageBuilder(
        (p0) => CourseDetailView(course: settings.arguments! as Course),
        settings: settings,
      );

    case CourseMaterialsView.routeName:
      return _pageBuilder(
        (p0) => BlocProvider(
          create: (context) => sl<MaterialCubit>(),
          child: CourseMaterialsView(settings.arguments! as Course),
        ),
        settings: settings,
      );

    case VideoPlayerView.routeName:
      return _pageBuilder(
        (p0) => VideoPlayerView(settings.arguments! as String),
        settings: settings,
      );

    case AddVideoView.routeName:
      return _pageBuilder(
        (p0) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<CourseCubit>()),
            BlocProvider(create: (_) => sl<VideoCubit>()),
            BlocProvider(create: (_) => sl<NotificationCubit>()),
          ],
          child: const AddVideoView(),
        ),
        settings: settings,
      );

    case AddMaterialsView.routeName:
      return _pageBuilder(
        (p0) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<CourseCubit>()),
            BlocProvider(create: (_) => sl<MaterialCubit>()),
            BlocProvider(create: (_) => sl<NotificationCubit>()),
          ],
          child: const AddMaterialsView(),
        ),
        settings: settings,
      );

    case AddExamView.routeName:
      return _pageBuilder(
        (p0) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<CourseCubit>()),
            BlocProvider(create: (_) => sl<ExamCubit>()),
            BlocProvider(create: (_) => sl<NotificationCubit>()),
          ],
          child: const AddExamView(),
        ),
        settings: settings,
      );

    case CourseVideosView.routeName:
      return _pageBuilder(
        (p0) => BlocProvider(
          create: (context) => sl<VideoCubit>(),
          child: CourseVideosView(settings.arguments! as Course),
        ),
        settings: settings,
      );

    case CourseExamView.routeName:
      return _pageBuilder(
        (p0) => BlocProvider(
          create: (context) => sl<ExamCubit>(),
          child: CourseExamView(settings.arguments! as Course),
        ),
        settings: settings,
      );

    case ExamDetailsView.routeName:
      return _pageBuilder(
        (p0) => BlocProvider(
          create: (context) => sl<ExamCubit>(),
          child: ExamDetailsView(settings.arguments! as Exam),
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
