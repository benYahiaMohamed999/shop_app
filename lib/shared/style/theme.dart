import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../componet/componet.dart';
import 'colors/colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black, //fou9 el AppBar Colors
      statusBarIconBrightness: Brightness.dark, //icons elfou9 batrie
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    elevation: 20.0,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
  ),
  fontFamily: 'Cairo',
);

ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('#877F80'), //fou9 el AppBar Colors
      statusBarIconBrightness: Brightness.light, //icons elfou9 batrie
    ),
    backgroundColor: HexColor('#877F80'),
    elevation: 0.0,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: HexColor('#877F80'),
  ),
  scaffoldBackgroundColor: HexColor('#877F80'),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  ),
  fontFamily: 'Cairo',
);
