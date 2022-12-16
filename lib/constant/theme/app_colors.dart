import 'package:flutter/material.dart';

@immutable
class AppColors {
  const AppColors._();

  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textBlack = Color(0xFF1F1F39);
  static const Color textRed = Color(0xFFEC6898);
  static const Color textGrey = Color(0xFF7A7C7D);
  static const Color dialogGrey = Color(0xFF8797B0);
  static const Color dialogBlack = Color(0xFF3D4045);
  static const Color bolderGrey = Color(0xFFE0EAF6);
  static const Color deepBlue = Color(0xFF4F5CBF);
  static const Color buttonGrey = Color(0xFFE0EAF7);
  static const Color searchBar = Color(0xFFB9C5D9);
  static const Color growPrice = Color(0xFF54CE58);
  static const Color opacityBackground = Color(0xC6000000);
  static const Color transParent = Color(0x00000000);
  static const Color transParentHalf = Color(0x80E1DBDB);
  static const Color prizeOrange = Color(0xFFF29049);
  static const Color prizePurple = Color(0xFF996CDD);

  static const Color datePickerBorder = Color(0xFFE0EAF6);

  static const Color pageUnChoose = Color(0xFFD9D9D9);
  static const Color jarCoinBg = Color(0xFF003268);
  static const Color homeArtBg = Color(0xFFEFF4FA);
  static const Color emptyCoffee = Color(0xFF5FC8AE);

  ///MARK:主題色彩
  static const Color mainThemeButton = Color(0xFF3B82F6);
  static const Color subThemePurple = Color(0xFF9657D7);
  static const Color mainBottomBg = Color(0xFFE0EAF7);
  static const Color reservationLevel0 = Color(0xFFF8B148);

  ///MARK: 漸層
  static const List<Color> gradientBaseColorBg = [
    Color(0xFF5CBFFE),
    Color(0xFFA0F5D0),
    Color(0xFFFFD7C8)
  ];

  static const List<Color> gradientBaseFlipColorBg = [
    Color(0xFFFFD7C8),
    Color(0xFFA0F5D0),
    Color(0xFF5CBFFE)
  ];

  ///MARK: 漸層
  static const List<Color> gradientBackgroundColorBg = [
    Color(0xFF99BCED),
    Color(0xFF99F8CF),
    Color(0xFFFFD6C7)
  ];

  /// trade btn
  static const Color reservationLevel1 = Color(0xFF27BEB5);
  static const Color reservationLevel2 = Color(0xFF34ACD7);
  static const Color reservationLevel3 = Color(0xFF1F6AC6);
  static const Color reservationLevel4 = Color(0xFF4051CB);
  static const Color reservationLevel5 = Color(0xFFCB4072);
  static const Color reservationLevel6 = Color(0xFFb7bcfb);

  /// trade draw result
  static const List<Color> drawColorBg = [
    Color(0xFFA1D8FE),
    Color(0xFF43B7FE),
    Color(0xFF44ACF7),
    Color(0xFF4890E3),
    Color(0xFF4E62C3),
  ];
  static const Color drawLine = Color(0xFF43F5F4);

  ///MARK: figma Color
  static const Color barFont01 = Color(0xFFB9C5D9);
  static const Color font02 = Color(0xFF8797B0);
}
