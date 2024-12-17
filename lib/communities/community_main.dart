import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oneul/communities/community_detail.dart';
import 'dart:convert';
import 'package:oneul/theme/app_colors.dart';
import 'package:oneul/assets/bottomNavbar.dart';
import 'package:go_router/go_router.dart';
import 'package:oneul/communities/community_post.dart';

class CommunityMainPage extends StatefulWidget {
  @override
  _CommunityMainPageState createState() => _CommunityMainPageState();
}

class _CommunityMainPageState extends State<CommunityMainPage> {
  List<Map<String, dynamic>> postData = [];
  bool isLoading = true;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchPostData();
  }
  Future<void> fetchPostData() async {
    final url = Uri.parse("https://raw.githubusercontent.com/noel-sumini/oneul/main/sample_community_list_data.json");

    try{
      final response = await http.get(url);

      if (response.statusCode == 200){
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          postData = data.map((item) => {
            "title" : item['title'] ?? "",
            "content": item['content'] ?? "",
            "author": item['author'] ?? ""
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
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        elevation: 0,
        title: Row(children: [
          Icon(Icons.school, color: Colors.white),
          SizedBox(width:5),
          Text("서울대학교", style: TextStyle(color: Colors.black, fontSize:18)),
          Icon(Icons.keyboard_arrow_down, color:Colors.black)
        ],),
        actions: [
          Icon(Icons.search, color:Colors.white),
          SizedBox(width: 15),
          Icon(Icons.notifications_none, color: Colors.white),
          SizedBox(width: 15)
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
            itemCount: postData.length,
            itemBuilder: (context, index) {
              final item = postData[index];
              return Container(
                decoration: BoxDecoration(
                  border:Border(bottom:BorderSide(color: Color(0xffCAC2D1)))
                ),
                // color: Colors.white,
                child: ListTile(
                
                title:Text(item['title']!,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(item['content']!),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16,),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CommunityDetailPage(post:item)));
                },
              ));
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
            MaterialPageRoute(builder: (context) => CommunityPostPage() )
          );
        },
      ),
    );
  }

}