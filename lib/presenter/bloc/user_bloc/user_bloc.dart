import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:redops_app/models/data/user_data_model.dart';
import '../../../http/repositories/user_repository.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  int page = 0;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      if (state is UserLoadedState &&
          (state as UserLoadedState).hasReachedMax) {
        return;
      }
      try {
        if (state is UserLoadingState) {
          final users = await _userRepository.getUsers(page: page);
          emit(UserLoadedState(users: users));
        } else if (state is UserLoadedState) {
          final currentState = state as UserLoadedState;
          final users = await _userRepository.getUsers(page: event.page);
          emit(users.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : UserLoadedState(users: currentState.users + users));
        }
        page += 1;
      } on DioException catch (error) {
        emit(UserErrorState(error.message!));
        throw Exception(error);
      }
    });
  }
}
