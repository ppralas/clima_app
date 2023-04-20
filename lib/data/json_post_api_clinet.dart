import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_weather/data/model/post_response.dart';
import 'package:new_weather/data/weather_api_client.dart';
import 'package:new_weather/domain/entities/post.dart';
import 'package:retrofit/retrofit.dart';

part 'json_post_api_clinet.g.dart';

final postClientProvider = Provider(
  (ref) => JsonPlaceholderApiClient(
    Dio()
      ..interceptors.add(
        TokenInterceptor(),
      ),
  ),
);

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com')
abstract class JsonPlaceholderApiClient {
  factory JsonPlaceholderApiClient(Dio dio, {String baseUrl}) =
      _JsonPlaceholderApiClient;

  @POST('/posts')
  Future<PostResponse> createPost(@Body() Post post);
}
