part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class LoadPostEvent extends PostEvent {
  final bool favorites;
  final int count;
  final int startIndex;

  const LoadPostEvent({required this.count, required this.startIndex, required this.favorites});

  @override
  List<Object?> get props => [count, startIndex, favorites];
}

class LoadFavEvent extends PostEvent {
  final int count;
  final int startIndex;

  const LoadFavEvent({required this.count, required this.startIndex,});

  @override
  List<Object?> get props => [count, startIndex,];
}