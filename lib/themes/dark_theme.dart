import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        color: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
        centerTitle: true),
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: Colors.black,
        primary: Colors.grey[900] as Color,
        secondary: Colors.grey[800] as Color));
