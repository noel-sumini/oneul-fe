import 'package:flutter/material.dart';
class CommentWidget extends StatelessWidget {
  final Map<String, dynamic> comment;
  final Function(String, {String? parentId}) onReply;
  final List<Map<String, dynamic>> replies;

  CommentWidget({
    required this.comment,
    required this.onReply,
    this.replies = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(comment['author'] ?? '익명'),
          subtitle: Text(comment['content'] ?? '내용 없음'),
          trailing: IconButton(
            icon: Icon(Icons.reply),
            onPressed: () => onReply("", parentId: comment['_id']),
          ),
        ),
        if (replies.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              children: replies
                  .map((reply) => CommentWidget(
                        comment: reply,
                        onReply: onReply,
                      ))
                  .toList(),
            ),
          ),
        if (replies.isEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              '답글이 없습니다.',
              style: TextStyle(color: Colors.grey),
            ),
          ),
      ],
    );
  }
}



class CommentInputWidget extends StatelessWidget {
  final Function(String, {String? parentId}) onSubmit;
  final String? parentId;

  CommentInputWidget({required this.onSubmit, this.parentId});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            
            decoration: InputDecoration(
              hintText: parentId == null
                  ? "댓글을 입력하세요..."
                  : "대댓글을 입력하세요...",
              contentPadding: EdgeInsets.symmetric(horizontal: 15)
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            if (controller.text.isNotEmpty) {
              onSubmit(controller.text, parentId: parentId);
              controller.clear();
            }
          },
        )
      ],
    );
  }
}
