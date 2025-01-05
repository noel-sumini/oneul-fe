import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:oneul/theme/app_colors.dart';
import 'package:go_router/go_router.dart';



class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();

}

class _TestPageState extends State {
  int counter = 0;

  void clickPlusButton() {
    setState((){
      counter ++;
    });
  }

  void clickMinusButton() {
    setState((){
      counter --;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.white,
      title: Text("내 플러터 앱"),
      ),
      body: Container(
        child: Column(
          children: [
          Text(
            "클릭 횟수: $counter",
            style: TextStyle(fontSize: 160.0),
          ),
          Row(
            children: [
              FloatingActionButton(
                backgroundColor: AppColors.secondary,
                shape: CircleBorder(),
                elevation: 4,
                child: Icon(Icons.exposure_plus_1, color:Colors.blue),
                onPressed: () {
                  clickPlusButton();
                },
              ),
              FloatingActionButton(
                backgroundColor: AppColors.secondary,
                shape: CircleBorder(),
                elevation: 4,
                child: Icon(Icons.exposure_minus_1, color:Colors.red),
                onPressed: () {
                  clickMinusButton();
                },
              )
            ],
          ),
        ]
      ),
    )
  );
}
}