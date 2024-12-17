import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:oneul/theme/app_colors.dart';
import 'package:oneul/assets/bottomNavbar.dart';
import 'package:go_router/go_router.dart';

class CommunityDetailPage extends StatefulWidget {
  final Map<String, dynamic> post;
  const CommunityDetailPage({super.key, required this.post});

  @override
  State<CommunityDetailPage> createState() => _CommunityDetailPageState();
}

class _CommunityDetailPageState extends State<CommunityDetailPage> {
  List<Map<String, dynamic>> comments = [];
  bool isLoading = true;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchPostData();
  }

  Future<void> fetchPostData() async {
    final url = Uri.parse("https://raw.githubusercontent.com/noel-sumini/oneul/main/sample_community_comment_data.json");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          comments = data.map((item) => {
            "author": item['author'] ?? "",
            "content": item['content'] ?? "",
            "replies": item['replies'] ?? []
          }).toList();
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load data");
      }
    } catch (error) {
      print("Error fetching data: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onNavBarTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        context.go('/meeting');
        break;
      case 1:
        context.go('/meeting');
        break;
      case 2:
        context.go('/meeting');
        break;
      case 3:
        context.go('/community');
        break;
      case 4:
        context.go('/community');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.school, color: Colors.white),
            SizedBox(width: 5),
            Text("서울대학교", style: TextStyle(color: Colors.black, fontSize: 18)),
            Icon(Icons.keyboard_arrow_down, color: Colors.black),
          ],
        ),
        actions: [
          Icon(Icons.search, color: Colors.white),
          SizedBox(width: 15),
          Icon(Icons.notifications_none, color: Colors.white),
          SizedBox(width: 15),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.post['title'] ?? "제목 없음",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(height: 8),
                      Text(widget.post['content'] ?? "내용 없음"),
                      const SizedBox(height: 8),
                      Text(widget.post['author'] ?? "작성자 없음",
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(comment['author']),
                            subtitle: Text(comment['content']),
                            trailing: IconButton(
                              icon: const Icon(Icons.reply),
                              onPressed: () {
                                setState(() {
                                  (comment['replies'] as List).add({
                                    "author": "대댓글작성자",
                                    "content": "새로운대댓글"
                                  });
                                });
                              },
                            ),
                          ),
                          if (comment['replies'] != null &&
                              comment['replies'].isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(left: 32.0),
                              child: Column(
                                children: List.generate(
                                  comment['replies'].length,
                                  (replyIndex) {
                                    final reply =
                                        comment['replies'][replyIndex];
                                    return ListTile(
                                      title: Text(reply['author']),
                                      subtitle: Text(reply['content']),
                                    );
                                  },
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
      bottomNavigationBar:
          BottomNavBar(currentIndex: _currentIndex, onTap: _onNavBarTapped),
    );
  }
}
