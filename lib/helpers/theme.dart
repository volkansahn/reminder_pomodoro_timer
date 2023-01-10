import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color darkGrey = Color(0xFF121212);

class Themes {
  static final lightTheme = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: Colors.amber,
    brightness: Brightness.light,
  );
  static final darkTheme = ThemeData(
    backgroundColor: darkGrey,
    primaryColor: darkGrey,
    brightness: Brightness.dark,
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  ));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  ));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w800,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  ));
}
