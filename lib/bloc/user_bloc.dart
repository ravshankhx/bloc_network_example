import 'package:bloc_network_example/bloc/user_event.dart';
import 'package:bloc_network_example/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/user.dart';
import '../services/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UsersRepository usersRepository;

  UserBloc(this.usersRepository) : super(UserEmptyState()) {
    on<UserEvent>(
      (event, emit) async {
        final List<User> _loadedUserList = await usersRepository.getAllUsers();
        if (event is UserLoadEvent) {
          emit(UserLoadingState());
          try {
            emit(UserLoadedState(loadedUser: _loadedUserList));
          } catch (e) {
            emit(UserErrorState());
          }
        } else if (event is UserClearEvent) {
          emit(UserEmptyState());
        }
      },
    );
  }
}
