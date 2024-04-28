import 'package:fca_education_app/%20core/errors/exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataSourceUtils {
  const DataSourceUtils._();
  static Future<void> authorizeUser(FirebaseAuth auth) {
    final user = auth.currentUser;
    if (user == null) {
      throw const ServerException(
        message: 'User is not authenticated',
        statusCode: '401',
      );
    }
    return Future.value();
  }
}
