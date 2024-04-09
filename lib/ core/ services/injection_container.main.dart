part of 'injection_container.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  await _onBoardingInit();
  await _authInit();
}

Future<void> _authInit() async {
  sl
    ..registerFactory(
      () => AuthBloc(
        signIn: sl(),
        signUp: sl(),
        forgotPassword: sl(),
        updateUser: sl(),
      ),
    )
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => SignUp(sl()))
    ..registerLazySingleton(() => ForgotPassword(sl()))
    ..registerLazySingleton(() => UpdateUser(sl()))
    ..registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(authRemotedataSources: sl()),
    )
    ..registerLazySingleton<AuthRemotedataSources>(
      () => AuthRemotedataSourcesImpl(
        authClient: sl(),
        firestoreClient: sl(),
        dbClient: sl(),
      ),
    )
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}

Future<void> _onBoardingInit() async {
  final prefs = await SharedPreferences.getInstance();

  ///  Bloc
  sl
    ..registerFactory(
      () => OnBoardingCubit(
        cachingFirstTimer: sl(),
        checkIfUserIsFirstTimervoid: sl(),
      ),
    )
    // usecase
    ..registerLazySingleton(() => CacheFirstTimer(repo: sl()))
    ..registerLazySingleton(() => CheckUserIsFirstTimer(repo: sl()))

    // repo impletementation
    ..registerLazySingleton<OnBoardingRepo>(
      () => OnBoardingRepoImpl(onBoardingLocalDataSrc: sl()),
    )

    // local data source
    ..registerLazySingleton<OnBoardingLocalDataSrc>(
      () => OnBoardingLocalDataSrcImpl(prefs: sl()),
    )
    // shared preferences
    ..registerLazySingleton(() => prefs);
}
