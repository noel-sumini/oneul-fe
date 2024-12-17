import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:oneul/theme/app_colors.dart';
import 'package:oneul/assets/bottomNavbar.dart';
import 'package:oneul/meetings/meeting_post.dart';

class MeetingMainPage extends StatefulWidget {
  @override
  _MeetingMainPageState createState() => _MeetingMainPageState();
}

class _MeetingMainPageState extends State<MeetingMainPage> {
  List<Map<String, dynamic>> meetingData = [];
  bool isLoading = true;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchMeetingData();
  }

  Future<void> fetchMeetingData() async {
    final url = Uri.parse("https://raw.githubusercontent.com/noel-sumini/oneul/main/sample_data.json");


    try{
      final response = await http.get(url);

      if (response.statusCode == 200){
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          meetingData = data.map((item) => {
            "title": item['title'],
            "station": item['station'],
            "school": item['school'],
            "school_image": item['school_image'],
            "gender": item['gender'],
            "member_num": item['member_num'].toString(),
            "hashtags": item['hashtags'],
            "thumbnail_image": item['thumbnail_image'],
          }).toList();
          isLoading = false;
        });
      }
      else {
        throw Exception("Failed to load data");
      }
    }
    catch (error) {
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
        context.go('/community');
        break;
      case 2:
        context.go('/bookmark');
        break;
      case 3:
        context.go('/profile');
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
            Icon(Icons.location_on, color: Colors.white),
            SizedBox(width: 5),
            Text(
              "서울시 강남구",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            Icon(Icons.keyboard_arrow_down, color: Colors.white),
          ],
        ),
        actions: [
          Icon(Icons.search, color:Colors.white),
          SizedBox(width: 15),
          Icon(Icons.notifications_none, color: Colors.white),
          SizedBox(width: 15),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: meetingData.length,
              itemBuilder: (context, index) {
                final item = meetingData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  child: Container(
                    decoration: BoxDecoration(
                      
                      border: Border(bottom:BorderSide(color: Color(0xffCAC2D1)))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 좌측 이미지
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item['thumbnail_image'],  // 웹 URL로부터 이미지를 가져옵니다
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 15),
                          // 우측 텍스트
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 첫 번째 Row: title
                                Text(
                                  item['title'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                // 두 번째 Row: station, school, gender, member_num
                                Row(
                                  children: [
                                    Icon(Icons.train, size: 16),
                                    SizedBox(width: 5),
                                    Text(item['station']),
                                    SizedBox(width: 10),
                                    Icon(Icons.school, size: 16),
                                    SizedBox(width: 5),
                                    Text(item['school']),
                                    SizedBox(width: 10),
                                    Icon(Icons.person, size: 16),
                                    SizedBox(width: 5),
                                    Text('${item['gender']} · ${item['member_num']}명'),
                                  ],
                                ),
                                SizedBox(height: 5),
                                // 세 번째 Row: hashtags
                                Text(
                                  item['hashtags'],
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex, 
        onTap: _onNavBarTapped),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondary,
        shape: CircleBorder(),
        elevation: 4,
        child: Icon(Icons.add, color:Colors.white),
        onPressed: (){
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => MeetingPostPage() )
          );
        },
      ),
    );
  }
}
