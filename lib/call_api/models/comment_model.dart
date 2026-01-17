import 'package:ht_movie/call_api/models/user_model.dart';

class CommentModel {
  final String id;
  final String content;
  final DateTime createdAt;
  final UserModel user;
  final List<CommentReply> replies;

  CommentModel({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.user,
    required this.replies,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      user: UserModel.fromJson(json['user'] ?? {}),
      replies:
          (json['replies'] as List<dynamic>? )
              ?.map((e) => CommentReply.fromJson(e))
              .toList() ?? [],
    );
  }
}

class CommentReply {
  final String id;
  final String content;
  final DateTime createdAt;
  final UserModel user;

  CommentReply({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.user,
  });

  factory CommentReply.fromJson(Map<String, dynamic> json) {
    return CommentReply(
      id: json['id'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      user: UserModel.fromJson(json['user'] ?? {}),
    );
  }
}
