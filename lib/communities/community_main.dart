import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:oneul/assets/bottomNavbar.dart'; // 원래 소스코드의 BottomNavBar
import 'package:oneul/theme/app_colors.dart'; // AppColors 사용
import 'package:oneul/communities/community_detail.dart';
import 'package:oneul/communities/community_post.dart';

class CommunityMainPage extends StatefulWidget {
  @override
  _CommunityMainPageState createState() => _CommunityMainPageState();
}

class _CommunityMainPageState extends State<CommunityMainPage> {
  List<Map<String, dynamic>> postData = [];
  bool isLoading = true; // 데이터 로딩 상태
  bool hasMore = true; // 더 가져올 데이터가 있는지 여부
  int currentPage = 1; // 현재 페이지 번호
  int startYear = 2024; // 조회할 게시물 연도
  final int pageSize = 20; // 페이지당 데이터 개수

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchPostData();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchPostData() async {
    if (!hasMore) return;

    final url = Uri.parse(
        "http://localhost:8000/posts?start_year=$startYear&page=$currentPage&size=$pageSize");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // final List<dynamic> data = json.decode(response.body);
        final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

        setState(() {
          postData.addAll(data.map((item) => {
                "post_id": item['post_id'] ?? 'id',
                "title": item['title'] ?? "제목 없음",
                "content": item['content'] ?? "",
                "author": item['author'] ?? "익명",
                "created_at": item['created_at'] ?? "",
                "comments": (item['comments'] is List) ? item['comments'] : [], // 안전하게 초기화
              }));
          isLoading = false;
          hasMore = data.length == pageSize; // 데이터가 더 있는지 확인
          currentPage++;
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


  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        hasMore &&
        !isLoading) {
      fetchPostData(); // 스크롤이 끝에 도달하면 추가 데이터 요청
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
      body: isLoading && postData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  postData.clear();
                  currentPage = 1;
                  hasMore = true;
                });
                await fetchPostData();
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: postData.length + (hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < postData.length) {
                    final item = postData[index];
                    return Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Color(0xffCAC2D1)),
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          item['title']!,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['content']!),
                            const SizedBox(height: 8),
                            Text(
                              "댓글 ${(item['comments'] is List) ? item['comments'].length : 0}개",
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommunityDetailPage(postId: item['post_id']),
                            ),
                          );
                        },
                      ),

                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3, // 커뮤니티 탭 활성화
        onTap: (index) {
          // 원하는 페이지로 이동
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondary,
        shape: const CircleBorder(),
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final Map<String, dynamic>? newPost = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CommunityPostPage(),
            ),
          );

          // 새로 추가된 게시물이 있을 경우 리스트에 추가
          if (newPost != null) {
            setState(() {
              postData.insert(0, newPost); // 리스트 맨 앞에 추가
            });
          }
        },
      ),
    );
  }
}
