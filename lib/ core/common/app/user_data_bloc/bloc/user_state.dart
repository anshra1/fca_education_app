part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

class UserDataState extends UserState {
  const UserDataState({required this.localUserModel});
  final LocalUserModel localUserModel;
}
