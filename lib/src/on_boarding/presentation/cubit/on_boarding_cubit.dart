import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fca_education_app/src/on_boarding/domain/usecase/cache_first_timer.dart';
import 'package:fca_education_app/src/on_boarding/domain/usecase/check_user_is_first_timer.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit({
    required CacheFirstTimer cachingFirstTimer,
    required CheckUserIsFirstTimer checkIfUserIsFirstTimervoid,
  })  : _cachingFirstTimer = cachingFirstTimer,
        _checkIfUserIsFirstTimervoid = checkIfUserIsFirstTimervoid,
        super(const OnBoardingInitial());

  final CacheFirstTimer _cachingFirstTimer;
  final CheckUserIsFirstTimer _checkIfUserIsFirstTimervoid;

  Future<void> cacheFirstTimer() async {
    emit(const CachingFirstTimer());

    final result = await _cachingFirstTimer();

    result.fold(
      (failure) => emit(
        OnBoardingError(message: failure.message),
      ),
      (_) => emit(const UserCached()),
    );
  }

  Future<void> checkIfUserIsFirstTimer() async {
    emit(const CheckIfUserIsFirstTimer());

    final result = await _checkIfUserIsFirstTimervoid();

    result.fold(
      (failure) => emit(const OnBoardingStatus(isFirstTimer: true)),
      (status) => emit(OnBoardingStatus(isFirstTimer: status)),
    );
  }
}
