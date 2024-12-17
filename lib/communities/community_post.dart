import 'package:flutter/material.dart';
import 'package:oneul/theme/app_colors.dart';
import 'package:oneul/assets/bottomNavbar.dart';

class CommunityPostPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, 
          children: [
            Icon(Icons.keyboard_arrow_down, color: Colors.black),
            Text("서울대학교", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 18))
          ]
        ),
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
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
              decoration: InputDecoration(labelText: "내용"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: "작성자"),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // 게시글 작성 완료 로직 추가 필요
                  print("Title: ${_titleController.text}");
                  print("Content: ${_contentController.text}");
                  print("Author: ${_authorController.text}");
                  Navigator.pop(context); // 작성 후 이전 페이지로 이동
                },
                child: Text("글 작성하기"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 3, onTap: (index) {
        Navigator.pop(context);
      }),
    );
  }
}
