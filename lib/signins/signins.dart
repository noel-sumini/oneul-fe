import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:oneul/theme/app_colors.dart';
import 'package:go_router/go_router.dart';


class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.gradient
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            // 제목: Oneul
            Text(
              'Oneul',
              style: GoogleFonts.comfortaa(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            // 문구: Shall we meet today 6pm?
            Text(
              'Shall we meet today 6pm?',
              style: GoogleFonts.comfortaa(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 40),
            // Sign In 버튼
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 128.0), // 좌우 여백 조정
              child: SizedBox(
                width: double.infinity, // 버튼을 부모의 가로 폭에 맞춤
                height: 50, // 버튼 높이 설정
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/meeting');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // 버튼 배경색
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // 모서리 둥글게
                    ),
                    elevation: 4, // 그림자 효과
                  ),
                  child: Text(
                    'Sign In',
                    style: GoogleFonts.comfortaa(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87, // 텍스트 색상
                    ),
                  ),
                ),
              ),
            ),



            const SizedBox(height: 24),
            // 아이콘 추가
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialIcon('assets/google_logo.png', Color(0xffFFFFFF)),
                const SizedBox(width: 24),
                _buildSocialIcon('assets/kakao_logo.png', Color(0xffFEE500)),
                const SizedBox(width: 24),
                _buildSocialIcon('assets/naver_logo.png', Color(0xff03C75A)),
              ],
            ),
            const Spacer(),
            // 하단 문구
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Text(
                'powered by Hi-Garage',
                style: GoogleFonts.comfortaa(fontSize: 14, color: Colors.black45),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 소셜 아이콘 생성 함수
  Widget _buildSocialIcon(String assetName, Color color) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(child: Image.asset(assetName, width:30, height: 30, fit:BoxFit.contain))
      //  Center(
      //   child: SvgPicture.asset(
      //     assetName,
      //     width: 30,
      //     height: 30,
      //   ),
        
      // ),
    );
  }
}
