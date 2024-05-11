import 'package:equatable/equatable.dart';
import 'package:fca_education_app/core/enum/user_data.dart';
import 'package:fca_education_app/core/usecases/usecases.dart';
import 'package:fca_education_app/core/utils/typedefs.dart';
import 'package:fca_education_app/src/auth/domain/auth_repo.dart/atuh_repo.dart';

class UpdateUser extends UseCaseWithParams<void, UpdateUserParams> {
  UpdateUser(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<void> call({required UpdateUserParams params}) {
    return _authRepo.updateUser(
      action: params.action,
      userData: params.userData,
    );
  }
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({
    required this.action,
    required this.userData,
  });

  const UpdateUserParams.empty()
      : this(
          action: UpdateUserAction.displyName,
          userData: '',
        );

  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<Object?> get props => [action, userData];
}
