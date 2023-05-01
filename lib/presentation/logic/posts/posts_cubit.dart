// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_freezed/data/core/handle_error.dart';
import 'package:test_freezed/domain/core/app_errors.dart';

import 'package:test_freezed/domain/models/post.dart';
import 'package:test_freezed/domain/repository/post.dart';

part 'posts_cubit.freezed.dart';
part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostsRepository repo;
  PostsCubit({
    required this.repo,
  }) : super(const PostsState.loading());

  void getPosts() async {
    emit(const PostsState.loading());

    Either<AppError, List<Post>> postsEither = await repo.getPosts();
    postsEither.fold(
      (error) {
        emit(PostsState.failure(getErrorMessage(error)));
      },
      (posts) {
        emit(PostsState.loaded(posts));
      },
    );
  }
}
