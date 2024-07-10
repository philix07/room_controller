import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyle {
  static TextStyle black({
    double fontSize = 12.0,
    TextOverflow overflow = TextOverflow.visible,
    FontWeight fontWeight = FontWeight.w700,
  }) {
    return GoogleFonts.openSans(
      color: AppColor.black,
      fontSize: fontSize,
      fontWeight: fontWeight,
      textStyle: TextStyle(overflow: overflow),
    );
  }

  static TextStyle white({
    double fontSize = 12.0,
    TextOverflow overflow = TextOverflow.visible,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return GoogleFonts.openSans(
      color: AppColor.white,
      fontSize: fontSize,
      fontWeight: fontWeight,
      textStyle: TextStyle(overflow: overflow),
    );
  }

  static TextStyle blue({
    double fontSize = 12.0,
    TextOverflow overflow = TextOverflow.visible,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return GoogleFonts.openSans(
      color: AppColor.blue,
      fontSize: fontSize,
      fontWeight: fontWeight,
      textStyle: TextStyle(overflow: overflow),
    );
  }

  static TextStyle gray({
    double fontSize = 12.0,
    TextOverflow overflow = TextOverflow.visible,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return GoogleFonts.openSans(
      color: AppColor.gray,
      fontSize: fontSize,
      fontWeight: fontWeight,
      textStyle: TextStyle(overflow: overflow),
    );
  }

  static TextStyle darkBrown({
    double fontSize = 12.0,
    TextOverflow overflow = TextOverflow.visible,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return GoogleFonts.openSans(
      color: AppColor.darkBrown,
      fontSize: fontSize,
      fontWeight: fontWeight,
      textStyle: TextStyle(overflow: overflow),
    );
  }

  static TextStyle red({
    double fontSize = 12.0,
    TextOverflow overflow = TextOverflow.visible,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return GoogleFonts.openSans(
      color: Colors.redAccent,
      fontSize: fontSize,
      fontWeight: fontWeight,
      textStyle: TextStyle(overflow: overflow),
    );
  }
}
