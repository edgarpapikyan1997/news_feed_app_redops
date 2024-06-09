import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../../http/repositories/post_repository.dart';
import '../../../models/post_model/post_model.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;
  int count = 5;
  int startIndex = 0;

  PostBloc(this._postRepository) : super(const PostLoadingState()) {
    on<LoadPostEvent>((event, emit) async {
      if (state is PostLoadedState &&
          (state as PostLoadedState).hasReachedMax) {
        return;
      }
      try {
        if (state is PostLoadingState) {
          final posts = await _postRepository.getAllPosts(
              count: event.count, startIndex: event.startIndex);
          emit(PostLoadedState(
            posts: posts,
            hasReachedMax: posts.length < count,
            favorites: const [],
          ));
        } else if (state is PostLoadedState) {
          final currentState = state as PostLoadedState;
          final posts = await _postRepository.getAllPosts(
              count: event.count, startIndex: event.startIndex);
          emit(posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : PostLoadedState(
                  posts: currentState.posts + posts,
                  hasReachedMax: posts.length < count,
                  favorites: const [],
                ));
          startIndex += count;
        }
      } on DioException catch (error) {
        emit(PostErrorState(message: error.toString()));
      }
    });
    on<LoadFavEvent>((event, emit) async {
      if (state is PostLoadedState &&
          (state as PostLoadedState).hasReachedMax) {
        return;
      }try {
        if(state is PostLoadingState) {

        }
      } on DioException catch(e) {
        throw Exception(e);
      };
    });
  }
}
