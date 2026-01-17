import 'package:flutter/material.dart';
import '../../../call_api/models/comment_model.dart';

class CommentList extends StatelessWidget {
  final List<CommentModel> comments;

  const CommentList({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600;
    final bool isSmallPhone = size.height < 700;

    return Column(
      children:
          comments
              .map(
                (e) => _buildComment(
                  context,
                  e,
                  isTablet: isTablet,
                  isSmallPhone: isSmallPhone,
                ),
              )
              .toList(),
    );
  }

  Widget _buildComment(
    BuildContext context,
    CommentModel comment, {
    required bool isTablet,
    required bool isSmallPhone,
  }) {
    final replyIndex = isTablet ? 72.0 : 48.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _commentItem(
          name: comment.user.name ?? 'User',
          avatarUrl: comment.user.avatarUrl,
          content: comment.content,
          time: _timeAgo(comment.createdAt),
          isTablet: isTablet,
          isSmallPhone: isSmallPhone,
        ),
        ...comment.replies.map(
          (reply) => Padding(
            padding: EdgeInsets.only(left: replyIndex),
            child: _commentItem(
              name: reply.user.name ?? 'User',
              avatarUrl: comment.user.avatarUrl,
              content: reply.content,
              time: _timeAgo(reply.createdAt),
              isTablet: isTablet,
              isSmallPhone: isSmallPhone,
            ),
          ),
        ),
      ],
    );
  }

  Widget _commentItem({
    required String name,
    required String content,
    required String time,
    required String? avatarUrl,
    required bool isTablet,
    required bool isSmallPhone,
  }) {
    final avatarSize =
        isTablet
            ? 24.0
            : isSmallPhone
            ? 14.0
            : 18.0;

    final padding =
        isTablet
            ? 20.0
            : isSmallPhone
            ? 12.0
            : 16.0;

    final nameSize =
        isTablet
            ? 16.0
            : isSmallPhone
            ? 13.0
            : 14.0;

    final contentSize =
        isTablet
            ? 15.0
            : isSmallPhone
            ? 12.5
            : 13.5;
    return Padding(
      padding: EdgeInsets.only(top: isSmallPhone ? 10 : 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: avatarSize * 2,
            height: avatarSize * 2,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white10,
            ),
            child: ClipOval(
              child:
                  (avatarUrl != null && avatarUrl.isNotEmpty)
                      ? Image.network(
                        avatarUrl,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.person, color: Colors.white54),
                      )
                      : const Icon(Icons.person, color: Colors.white54),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(padding),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(isTablet ? 24 : 20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: nameSize,
                          ),
                        ),
                      ),
                      SizedBox(width: 8,),
                      Text(
                        time,
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: isSmallPhone ? 10 : 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    content,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: contentSize,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Reply', style: TextStyle(color: Colors.white54)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
