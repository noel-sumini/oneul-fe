import 'package:flutter/material.dart';
import 'package:oneul/theme/app_colors.dart';
import 'package:oneul/assets/bottomNavbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http; // http 패키지 추가
import 'dart:convert'; // JSON 인코딩/디코딩을 위한 패키지

class CommunityPostPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  Future<void> submitPost(BuildContext context) async {
    final String apiUrl = "http://localhost:8000/posts";

    // 게시물 데이터 생성
    Map<String, dynamic> postData = {
      "author": _authorController.text,
      "title" : _titleController.text,
      "content": _contentController.text,
      "liked": 0, 
      "additional_data": {"hashtags" : ""} 
    };

    try {
      // POST 요청
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(postData),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        // final newPost = json.decode(response.body);
        final newPost = jsonDecode(utf8.decode(response.bodyBytes));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("게시물이 성공적으로 등록되었습니다.")),
        );
        Navigator.pop(context, newPost); // 새 게시물 데이터 반환
      } else {
        print("Failed to submit post: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("게시물 등록에 실패했습니다.")),
        );
      }

    } catch (e) {
      // 예외 처리
      print("Error submitting post: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("네트워크 오류가 발생했습니다.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.keyboard_arrow_down, color: Colors.black),
            Text("서울대학교",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 18))
          ],
        ),
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          ElevatedButton(
            onPressed: () {
              submitPost(context); // 버튼 클릭 시 submitPost 호출
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // 모서리 둥글게
              ),
              minimumSize: Size(50, 45),
            ),
            child: Text(
              "등록",
              style: GoogleFonts.comfortaa(fontSize: 18),
            ),
          ),
          SizedBox(width: 15)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "제목을 입력해주세요"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: InputDecoration(labelText: "내용을 입력해주세요"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: "작성자"),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onTap: (index) {
          Navigator.pop(context);
        },
      ),
    );
  }
}
