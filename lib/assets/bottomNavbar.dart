import 'package:flutter/material.dart';
import 'package:oneul/theme/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      fixedColor: AppColors.secondary,
      items: [
        BottomNavigationBarItem(
          icon: Column(
            children: [
              Icon(Icons.home),
              Text("미팅", style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Column(
            children: [
              Icon(Icons.menu),
              Text("커뮤니티", style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Column(
            children: [
              Icon(Icons.favorite_border),
              Text("북마크", style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          label: "",
        ),  
        // BottomNavigationBarItem(
        //   icon: Container(
        //     width: 70, // 버튼의 가로 길이를 늘려 타원형으로 만듭니다.
        //     height: 40, // 세로 길이는 유지합니다.
        //     decoration: BoxDecoration(
        //       gradient: AppColors.gradient,
        //       borderRadius: BorderRadius.circular(25), // 타원형으로 만듭니다.
        //     ),
        //     child: Icon(Icons.add, color: Colors.white),
        //   ),
        //   label: "",
        // ),
        
        BottomNavigationBarItem(
          icon: Column(
            children: [
              Icon(Icons.person),
              Text("내 프로필", style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Column(
            children: [
              Icon(Icons.account_circle),
              Text("테스트", style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          label: "",
        ),
      ],
    );
  }
}
