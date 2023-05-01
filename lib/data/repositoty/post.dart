import 'package:dio/dio.dart';
import 'package:test_freezed/data/core/api.dart';
import 'package:test_freezed/data/core/handle_error.dart';
import 'package:test_freezed/domain/models/post.dart';
import 'package:test_freezed/domain/core/app_errors.dart';
import 'package:dartz/dartz.dart';
import 'package:test_freezed/domain/repository/post.dart';
import 'package:test_freezed/utils/logger.dart';

class PostsRepositoryImpl implements PostsRepository {
  late final Dio _dio;

  PostsRepositoryImpl() {
    _dio = Dio();
  }
  @override
  Future<Either<AppError, List<Post>>> getPosts() async {
    String url = '${Api.baseUrl}posts';
    late List<Post> categories;
    Response response;
    try {
      response = await _dio.get(
        url,
        options: Options(contentType: "application/json"),
      );
      categories = List<Map<String, dynamic>>.from(response.data!)
          .map((map) => Post.fromJson(map))
          .toList();
    } on DioError catch (e) {
      logger.e(e.toString());
      return handleDioError<List<Post>>(e);
    } catch (e) {
      logger.e(e);
      return left(AppError.unexpected);
    }
    return right(categories);
  }
}
