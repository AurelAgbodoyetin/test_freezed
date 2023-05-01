import 'package:dartz/dartz.dart';
import 'package:test_freezed/domain/core/app_errors.dart';
import 'package:test_freezed/domain/models/post.dart';

abstract class PostsRepository {
  Future<Either<AppError, List<Post>>> getPosts();
}
