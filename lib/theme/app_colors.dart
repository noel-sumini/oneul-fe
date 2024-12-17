import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFBCC7DC);
  static const Color secondary = Color(0xFFCAC2D1);
  static const Color background = Color(0xFFFAD4D2);
  static const Color textPrimary = Color(0xFFFDDED7);
  static const Color textSecondary = Color(0xFFFAE5D5);
  static const LinearGradient gradient = LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                                    Color(0xFFBCC7DC),
                                                    Color(0xFFCAC2D1),
                                                    Color(0xFFFAD4D2),
                                                    Color(0xFFFDDED7),
                                                    Color(0xFFFAE5D5),
                                                  ], 
                                          );
}