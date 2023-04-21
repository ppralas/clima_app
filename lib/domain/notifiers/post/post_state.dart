import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:new_weather/domain/entities/failure.dart';
import 'package:new_weather/domain/entities/post.dart';

part 'post_state.freezed.dart';

@freezed
class PostState with _$PostState {
  //definirat koje cu imati stateove,
  const factory PostState.initial() = _Initial;
  const factory PostState.loading() = _Posting;
  const factory PostState.failure(Failure failure) = _Failure;
  //Za razliku od beer projekta ovdje samo objekt redajem ne slistu jer en cuvam listu prognoza
  const factory PostState.posted(Post post) = _Posted;
  const factory PostState.empty() = _Empty;
}
