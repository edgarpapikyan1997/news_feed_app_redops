part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUserEvent extends UserEvent {
  final int page;

  const LoadUserEvent({required this.page});

  @override
  List<Object?> get props => [page];
}
