part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

class PostLoadingState extends PostState {
  const PostLoadingState();
}

class PostLoadedState extends PostState {
  final List<PostModel> posts;
  final List<PostModel> favorites;
  final bool hasReachedMax;

  const PostLoadedState(
      {required this.posts,
      this.hasReachedMax = false,
      required this.favorites});

  PostLoadedState copyWith(
      {List<PostModel>? posts,
      bool? hasReachedMax,
      List<PostModel>? favorites}) {
    return PostLoadedState(
        posts: posts ?? this.posts,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        favorites: favorites ?? this.favorites);
  }

  @override
  List<Object?> get props => [posts, hasReachedMax, favorites];
}


class PostErrorState extends PostState {
  final String message;

  const PostErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
