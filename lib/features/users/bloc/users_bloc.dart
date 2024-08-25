import 'dart:async';
import 'package:Users/features/users/data/models/users_model.dart';
import 'package:Users/features/users/data/repos/user_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitial()) {
    on<UsersInitialfetchEvent>(usersInitialfetchEvent);
  }

  FutureOr<void> usersInitialfetchEvent(
   UsersInitialfetchEvent event, Emitter<UsersState> emit) async {
    try {
      final users = await fetchUsers();
      emit(UserfetchingSuccessful(users: users));
    }catch (e) {
    
    emit(UserFetchingFailed(errorMessage: e.toString()));
  }
}


}

