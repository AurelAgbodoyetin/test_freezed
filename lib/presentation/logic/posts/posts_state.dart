part of 'posts_cubit.dart';

@freezed
class PostsState with _$PostsState {
  const factory PostsState.loading() = Loading;
  const factory PostsState.loaded(List<Post> posts) = Loaded;
  const factory PostsState.failure(String error) = Failure;
}
