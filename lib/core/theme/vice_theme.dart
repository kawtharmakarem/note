import 'package:flutter/material.dart';

import 'vice_colors.dart';

class ViceTheme {
  ViceTheme._();
  static ThemeData get theme => ThemeData(
    primarySwatch: Colors.purple,
    primaryColor: ViceColor.purple,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white54,
      filled: true,
      contentPadding: EdgeInsets.all(10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
