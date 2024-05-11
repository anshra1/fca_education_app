import 'package:fca_education_app/core/utils/typedefs.dart';

abstract class OnBoardingRepo {
  const OnBoardingRepo();

  ResultFuture<void> cacheFirstTimer();
  ResultFuture<bool> checkIfUserIsFirstTimer();
}
