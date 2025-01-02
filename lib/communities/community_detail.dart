import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:oneul/theme/app_colors.dart';
import 'package:oneul/assets/bottomNavbar.dart';
import 'package:oneul/communities/commentWidget.dart';

class CommunityDetailPage extends StatefulWidget {
  final String postId;
  const CommunityDetailPage({super.key, required this.postId});

  @override
  State<CommunityDetailPage> createState() => _CommunityDetailPageState();
}
class CommentService {
  final String baseUrl;

  CommentService(this.baseUrl);

  // 댓글 조회
  Future<List<Map<String, dynamic>>> fetchComments(String postId) async {
    final response = await http.get(Uri.parse('$baseUrl/comments/$postId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is List) {
        return List<Map<String, dynamic>>.from(data);
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load comments');
    }
  }
    

  // 댓글 추가
  Future<void> addComment(String postId, String content,
      {String? parentId}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/comments'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'post_id': postId,
        'parent_comment_id': parentId,
        'author': 'User',
        'content': content,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add comment');
    }
  }

  // 게시글 상세 정보 조회
  Future<Map<String, dynamic>> fetchPostDetail(String postId) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/$postId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post details');
    }
  }
}


class _CommunityDetailPageState extends State<CommunityDetailPage> {
  final CommentService _commentService = CommentService('http://localhost:8000');
  List<Map<String, dynamic>> comments = [];
  Map<String, dynamic>? postDetail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchContent();
  }

  Future<void> fetchContent() async {
    try {
      final fetchedPostDetail =
          await _commentService.fetchPostDetail(widget.postId);
      final fetchedComments =
          await _commentService.fetchComments(widget.postId);

      setState(() {
        postDetail = fetchedPostDetail;
        comments = fetchedComments;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching content: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> addComment(String content, {String? parentId}) async {
    try {
      await _commentService.addComment(widget.postId, content,
          parentId: parentId);
      await fetchContent(); // 새로고침
    } catch (e) {
      print('Error adding comment: $e');
    }
  }
@override
@override
Widget build(BuildContext context) {
  // 화면의 크기나 키보드 높이를 가져옵니다.
  double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

  return Scaffold(
    appBar: AppBar(
      backgroundColor: AppColors.secondary,
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.school, color: Colors.white),
          SizedBox(width: 5),
          Text(
            "서울대학교",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          Icon(Icons.keyboard_arrow_down, color: Colors.black),
        ],
      ),
      actions: const [
        Icon(Icons.search, color: Colors.white),
        SizedBox(width: 15),
        Icon(Icons.notifications_none, color: Colors.white),
        SizedBox(width: 15),
      ],
    ),
    body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : postDetail == null
            ? const Center(child: Text('게시글을 불러올 수 없습니다.'))
            : Stack(
                children: [
                  // 댓글 목록을 스크롤할 수 있도록 감싸는 위젯
                  Padding(
                    padding: EdgeInsets.only(bottom: keyboardHeight + 60), // 하단 여유 공간을 두기 위해 padding 추가
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  postDetail!['title'] ?? '제목 없음',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                                const SizedBox(height: 8),
                                Text(postDetail!['content'] ?? '내용 없음'),
                                const SizedBox(height: 8),
                                Text('작성자: ${postDetail!['author']}'),
                              ],
                            ),
                          ),
                          const Divider(),
                          comments.isEmpty
                              ? const Center(
                                  child: Text('댓글이 없습니다. 첫 댓글을 작성해보세요!'),
                                )
                              : ListView.builder(
                                  shrinkWrap: true, // ListView가 Column 내에서 크기를 조정하도록 설정
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: comments.length,
                                  itemBuilder: (context, index) {
                                    final comment = comments[index];
                                    final replies = comment['replies'] ?? [];
                                    return CommentWidget(
                                      comment: comment,
                                      replies: List<Map<String, dynamic>>.from(replies),
                                      onReply: addComment,
                                    );
                                  },
                                ),
                        ],
                      )
                    ),
                  ),
                  // 댓글 입력 위젯을 화면 하단에 고정
                  Positioned(
                    bottom: keyboardHeight, // 키보드 높이를 고려하여 고정
                    left: 0,
                    right: 0,
                    child: CommentInputWidget(onSubmit: addComment),
                  ),
                ],
              ),
  );
}

}
