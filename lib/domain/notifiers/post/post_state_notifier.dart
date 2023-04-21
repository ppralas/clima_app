import 'package:new_weather/data/model/post_repository.dart';
import 'package:new_weather/domain/entities/post.dart';
import 'package:new_weather/domain/notifiers/post/post_state.dart';
import 'package:riverpod/riverpod.dart';

final postValueProvider = StateNotifierProvider<PostStateNotifier, PostState>(
    (ref) => PostStateNotifier(ref.watch(postRepositoryProvider)));

class PostStateNotifier extends StateNotifier<PostState> {
  final PostRepository _postRepository;

  PostStateNotifier(this._postRepository)
      : super(
          const PostState.empty(),
        );

  void publishPost({required String title, required String body}) async {
    final post = Post(id: 1, userId: 2, title: title, body: body);
    final result = await _postRepository.createPost(post);
    result.fold(
        // state u svakoj od linija ispod updatea state
        (error) => state = PostState.failure(error),
        (post) => state = PostState.posted(post));
  }
}
