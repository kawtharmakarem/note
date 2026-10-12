import 'package:flutter/material.dart';

import '/core/responsive_services/responsive_font_size.dart';
import '/core/utils/app_colors.dart';

class AppStyles {
  AppStyles._();

  static TextStyle _getTextStyle(
    BuildContext context, {
    String fontFamily = "Sentic Display",
    double fontSize = 16,
    Color color = AppColors.mainTextColor,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: fontSize),
      color: color,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
    );
  }

  static TextStyle splashText(BuildContext context) {
    return _getTextStyle(
      context,
      fontWeight: FontWeight.w700,
      fontFamily: "Goffik-O",
      fontSize: 60,
    ).copyWith(letterSpacing: 2);
  }

  //regular
  static TextStyle regular(BuildContext context, double fontSize) {
    return _getTextStyle(context, fontSize: fontSize);
  }

  //medium
  static TextStyle medium(BuildContext context, double fontSize) {
    return _getTextStyle(
      context,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
    );
  }

  //light
  static TextStyle light(BuildContext context, double fontSize) {
    return _getTextStyle(
      context,
      fontSize: fontSize,
      fontWeight: FontWeight.w300,
    );
  }

  //semibold
  static TextStyle semiBold(BuildContext context, double fontSize) {
    return _getTextStyle(
      context,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
    );
  }

  //light
  static TextStyle bold(BuildContext context, double fontSize) {
    return _getTextStyle(
      context,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
    );
  }

  //white regular for buttons
  static TextStyle whiteRegular(BuildContext context, double fontSize) {
    return _getTextStyle(context, fontSize: fontSize, color: AppColors.white);
  }
}
