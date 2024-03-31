import 'package:dartz/dartz.dart';
import 'package:fca_education_app/%20core/errors/exception.dart';
import 'package:fca_education_app/%20core/errors/failure.dart';
import 'package:fca_education_app/%20core/utils/typedefs.dart';
import 'package:fca_education_app/src/on_boarding/data/datasources/on_boarding_local_data_src.dart';
import 'package:fca_education_app/src/on_boarding/domain/repo/on_boarding_repo.dart';

class OnBoardingRepoImpl implements OnBoardingRepo {
  OnBoardingRepoImpl({
    required this.onBoardingLocalDataSrc,
  });

  final OnBoardingLocalDataSrc onBoardingLocalDataSrc;

  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      await onBoardingLocalDataSrc.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(
        CacheFailure.fromException(
          cacheException: e,
        ),
      );
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTimer()async {
    throw UnimplementedError();
  }
}
