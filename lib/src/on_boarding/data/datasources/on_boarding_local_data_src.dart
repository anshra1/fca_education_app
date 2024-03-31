import 'package:fca_education_app/%20core/errors/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OnBoardingLocalDataSrc {
  const OnBoardingLocalDataSrc();
  Future<bool> checkIfUserIsFirstTimer();
  Future<void> cacheFirstTimer();
}

const kFirstTimer = 'kFirstTimer';

class OnBoardingLocalDataSrcImpl implements OnBoardingLocalDataSrc {
  const OnBoardingLocalDataSrcImpl({
    required this.prefs,
  });

  final SharedPreferences prefs;

  @override
  Future<bool> checkIfUserIsFirstTimer() async {
    try {
      return prefs.getBool(kFirstTimer) ?? true;
    } catch (e) {
      throw CacheException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<void> cacheFirstTimer() async {
    try {
      await prefs.setBool(kFirstTimer, false);
    } catch (e) {
      throw CacheException(message: e.toString(), statusCode: 400);
    }
  }
}
