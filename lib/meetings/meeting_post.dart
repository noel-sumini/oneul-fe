import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oneul/theme/app_colors.dart';
import 'package:oneul/assets/bottomNavbar.dart';

class MeetingPostPage extends StatelessWidget {
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
              decoration: InputDecoration(labelText: "선호 위치를 입력해주세요"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _authorController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(labelText: "인원수를 입력해주세요"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: "자기소개를 입력해주세요!", hintText: "자세하게 입력할수록 매칭확률이 올라가요!"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: "원하시는 미팅 상대에 대한 정보를 입력해주세요", hintText: "자세하게 입력할수록 원하는 상대와 매칭확률이 올라가요!"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: "해시태그를 입력해주세요", hintText: "매칭상대에게 보여줄 재미있는 해시태그를입력해주세요!"),
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
