part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

// class UserLocalDataModelEvent extends UserEvent {
//   const UserLocalDataModelEvent({required this.localUserModel});

//   final LocalUserModel localUserModel;
// }
