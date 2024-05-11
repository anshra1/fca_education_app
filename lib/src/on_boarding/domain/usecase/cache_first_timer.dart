import 'package:fca_education_app/core/usecases/usecases.dart';
import 'package:fca_education_app/core/utils/typedefs.dart';
import 'package:fca_education_app/src/on_boarding/domain/repo/on_boarding_repo.dart';

class CacheFirstTimer implements UseCaseWithoutParam<void> {
  CacheFirstTimer({
    required this.repo,
  });

  final OnBoardingRepo repo;
  
  @override
  ResultFuture<void> call() {
    return repo.cacheFirstTimer();
  }
}
