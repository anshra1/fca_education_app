import 'package:fca_education_app/%20core/usecases/usecases.dart';
import 'package:fca_education_app/%20core/utils/typedefs.dart';
import 'package:fca_education_app/src/auth/domain/auth_repo.dart/atuh_repo.dart';

class ForgotPassword extends UseCaseWithParams<void, String> {
  ForgotPassword(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<void> call({required String params}) {
    return _authRepo.forgotPassword(email: params);
  }
}
