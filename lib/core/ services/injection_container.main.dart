part of 'injection_container.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  await _onBoardingInit();
  await _authInit();
  await _courseInit();
  await _initVideo();
  await _initMaterial();
  await _initExam();
  await _initNotification();
}

Future<void> _initNotification() async {
  sl
    ..registerFactory(
      () => NotificationCubit(
        clear: sl(),
        clearAll: sl(),
        getNotifications: sl(),
        markAsRead: sl(),
        sendNotification: sl(),
      ),
    )
    ..registerLazySingleton(() => Clear(notificationRepo: sl()))
    ..registerLazySingleton(() => ClearAll(notificationRepo: sl()))
    ..registerLazySingleton(() => GetNotifications(notificationRepo: sl()))
    ..registerLazySingleton(() => MarkAsRead(notificationRepo: sl()))
    ..registerLazySingleton(() => SendNotification(notificationRepo: sl()))
    //
    ..registerLazySingleton<NotificationRepo>(() => NotificationRepoImpl(sl()))
    //
    ..registerLazySingleton<NotificationRemoteDataSrc>(
      () => NotificationRemoteDataSrcImpl(firestore: sl(), auth: sl()),
    );
}

Future<void> _initExam() async {
  sl
    ..registerFactory(
      () => ExamCubit(
        getExamQuestions: sl(),
        getExams: sl(),
        submitExam: sl(),
        updateExam: sl(),
        uploadExam: sl(),
        getUserCourseExams: sl(),
        getUserExams: sl(),
      ),
    )
    ..registerLazySingleton(() => GetExamQuestion(examRepo: sl()))
    ..registerLazySingleton(() => GetExams(examRepo: sl()))
    ..registerLazySingleton(() => SubmitExam(examRepo: sl()))
    ..registerLazySingleton(() => UpdateExam(examRepo: sl()))
    ..registerLazySingleton(() => UploadExam(examRepo: sl()))
    ..registerLazySingleton(() => GetUserCourseExams(examRepo: sl()))
    ..registerLazySingleton(() => GetUserExam(examRepo: sl()))
    ..registerLazySingleton<ExamRepo>(() => ExamRepoImpl(sl()))
    ..registerLazySingleton<ExamRemoteDataSrc>(
      () => ExamRemoteDataSrcImpl(
        auth: sl(),
        firestore: sl(),
      ),
    );
}

Future<void> _initMaterial() async {
  sl
    ..registerFactory(
      () => MaterialCubit(addMaterial: sl(), getMaterials: sl()),
    )
    ..registerLazySingleton(() => AddMaterial(sl()))
    ..registerLazySingleton(() => GetMaterials(sl()))
    ..registerLazySingleton<MaterialRepo>(() => MaterialRepoImpl(sl()))
    ..registerLazySingleton<MaterialRemoteDataSrc>(
      () => MaterialRemoteDataSrcImpl(
        firestore: sl(),
        auth: sl(),
        storage: sl(),
      ),
    );
  // ..registerFactory(() => ResourceController(storage: sl(), prefs: sl()));
}

Future<void> _courseInit() async {
  sl
    ..registerFactory(
      () => CourseCubit(
        addCourse: sl(),
        getCourse: sl(),
      ),
    )
    ..registerLazySingleton(
      () => AddCourses(courseRepo: sl()),
    )
    ..registerLazySingleton(
      () => GetCourse(courseRepo: sl()),
    )
    ..registerLazySingleton<CourseRepo>(
      () => CourseRepoImpl(sl()),
    )
    ..registerLazySingleton<CourseRemtoeDataSrc>(
      () => CourseRemoteDataSrcImpl(
        firestore: sl(),
        storage: sl(),
        auth: sl(),
      ),
    );
}

Future<void> _initVideo() async {
  sl
    ..registerFactory(
      () => VideoCubit(
        addVideo: sl(),
        getVideos: sl(),
      ),
    )
    ..registerLazySingleton(() => AddVideo(repo: sl()))
    ..registerLazySingleton(() => GetVideos(repo: sl()))
    ..registerLazySingleton<VideoRepo>(
      () => VideoRepoImpl(videoRemoteDataSrc: sl()),
    )
    ..registerLazySingleton<VideoRemoteDataSrc>(
      () => VideoRemoteDataSrcImpl(firestore: sl(), auth: sl(), storage: sl()),
    );
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
