part of 'user_bloc.dart';

abstract class UserState extends Equatable {}

class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadedState extends UserState {
  final List<UserDataModel> users;
  final bool hasReachedMax;
  final bool noMoreData;

  UserLoadedState({
    required this.users,
    this.hasReachedMax = false,
    this.noMoreData = false,
  });

  UserLoadedState copyWith(
      {List<UserDataModel>? users, bool? hasReachedMax, bool? noMoreData}) {
    return UserLoadedState(
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      noMoreData: noMoreData ?? this.noMoreData,
    );
  }

  @override
  List<Object?> get props => [users, hasReachedMax, noMoreData];
}

class UserErrorState extends UserState {
  final String error;

  UserErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
