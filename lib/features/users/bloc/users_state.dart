part of 'users_bloc.dart';

@immutable
abstract class UsersState {}

abstract class UserActionState extends UsersState{}

final class UsersInitial extends UsersState {}

 class UserfetchingSuccessful extends UsersState {
   late final List<UserModel> users;
   UserfetchingSuccessful({
    required this.users,
   });
}
class UserFetchingFailed extends UsersState {
  final String errorMessage;

  UserFetchingFailed({required this.errorMessage});
}
