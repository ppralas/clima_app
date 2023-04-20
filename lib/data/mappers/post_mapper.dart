import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_weather/data/model/post_response.dart';
import 'package:new_weather/data/utils/mapper.dart';
import 'package:new_weather/domain/entities/post.dart';

final postEntityMapperProvider = Provider<EntityMapper<Post, PostResponse>>(
  (ref) => (response) => Post(
      id: response.id,
      userId: response.userId,
      title: response.title,
      body: response.body),
);
