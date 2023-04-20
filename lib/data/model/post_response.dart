import 'package:json_annotation/json_annotation.dart';

part 'post_response.g.dart';

@JsonSerializable()
class PostResponse {
  int id;
  int userId;
  String title;
  String body;

  PostResponse({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
        id: json['id'],
        userId: json['userId'],
        title: json['title'],
        body: json['body'],
      );
}
