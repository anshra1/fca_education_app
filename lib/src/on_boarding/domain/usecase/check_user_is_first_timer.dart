import 'package:fca_education_app/%20core/usecases/usecases.dart';
import 'package:fca_education_app/%20core/utils/typedefs.dart';
import 'package:fca_education_app/src/on_boarding/domain/repo/on_boarding_repo.dart';

class CheckUserIsFirstTimer implements UseCaseWithoutParam<bool> {
  CheckUserIsFirstTimer({
    required this.repo,
  });

  final OnBoardingRepo repo;

  @override
  ResultFuture<bool> call() {
    return repo.checkIfUserIsFirstTimer();
  }
}
