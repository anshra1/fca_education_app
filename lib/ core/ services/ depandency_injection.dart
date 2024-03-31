import 'package:fca_education_app/src/on_boarding/data/datasources/on_boarding_local_data_src.dart';
import 'package:fca_education_app/src/on_boarding/data/repo/on_boarding_repo_impl.dart';
import 'package:fca_education_app/src/on_boarding/domain/repo/on_boarding_repo.dart';
import 'package:fca_education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
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
    ..registerLazySingleton(() => const CachingFirstTimer())
    ..registerLazySingleton(() => const CheckIfUserIsFirstTimer())

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
