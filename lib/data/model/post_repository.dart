import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_weather/data/json_post_api_client.dart';
import 'package:new_weather/data/mappers/post_mapper.dart';
import 'package:new_weather/data/model/post_response.dart';
import 'package:new_weather/data/utils/mapper.dart';
import 'package:new_weather/domain/entities/failure.dart';
import 'package:new_weather/domain/entities/post.dart';

final postRepositoryProvider = Provider(
  (ref) => PostRepositoryImpl(
    ref.watch(postClientProvider),
    ref.watch(postEntityMapperProvider),
  ),
);

abstract class PostRepository {
  Future<Either<Failure, Post>> createPost(Post postRequest);
}

class PostRepositoryImpl extends PostRepository {
  final JsonPlaceholderApiClient postApi;
  final EntityMapper<Post, PostResponse> mapper;

  PostRepositoryImpl(this.postApi, this.mapper);

  @override
  Future<Either<Failure, Post>> createPost(Post postRequest) async {
    try {
      final postResponse = await postApi.createPost(postRequest);
      final post = mapper.call(postResponse);
      return right(post);
    } catch (error, stackTrace) {
      return left(Failure(error, stackTrace));
    }
  }
}
