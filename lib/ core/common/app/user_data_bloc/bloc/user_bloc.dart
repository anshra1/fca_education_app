import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fca_education_app/src/auth/datasources/models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({
    required this.localUserModel,
  }) : super(UserDataState(localUserModel: localUserModel));

  LocalUserModel localUserModel;
  LocalUserModel get user => localUserModel;

  set user(LocalUserModel? user) {
    if (localUserModel != user) {
      localUserModel = user!;
    }
  }

  void initUser(LocalUserModel user) {
    if (localUserModel != user) localUserModel = user;
  }
}
