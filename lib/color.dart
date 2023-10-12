import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainColor {
  static Color primaryColor = const Color(0xFF00061a);
  static Color secondaryColor = const Color(0xFF001456);
  static Color accentColor = const Color(0xFF4169e8);
}

class ThemeService {
  final lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,

    appBarTheme: AppBarTheme(
      titleSpacing: 25.0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: MainColor.secondaryColor,
      elevation: 8.0,
      titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'jannah'),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    ),
    textTheme: TextTheme(
      headline1: const TextStyle(
        fontSize: 35.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headline6: const TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'jannah',
      ),
      headline4:TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold,
        color: MainColor.primaryColor,
        fontFamily: 'jannah',
      ),
      subtitle1: const TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontFamily: 'jannah',
      ),
      subtitle2: const TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontFamily: 'jannah',
      ),
    ),
    cardColor: Colors.black

  );

  final darkTheme = ThemeData.light().copyWith(
      primaryColor: const Color(0xFF00061a),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: MainColor.primaryColor,
    cardColor: Colors.white,

    appBarTheme: const AppBarTheme(
        titleSpacing: 25.0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.white10,
        elevation: 8.0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontFamily: 'jannah',
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontSize: 35.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headline6: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'jannah',
        ),
        subtitle1: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontFamily: 'jannah',
        ),
        headline4:TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'jannah',
        ),
        subtitle2: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontFamily: 'jannah',
        ),
      ),
      buttonTheme: const ButtonThemeData(buttonColor: Color(0xFF001456)));

  final _getStorage = GetStorage();
  final _darkThemeKey = 'isDarkTheme';

  void saveThemeData(bool isDarkMode) {
    _getStorage.write(_darkThemeKey, isDarkMode);
  }

  bool isSavedDarkMode() {
    return _getStorage.read(_darkThemeKey) ?? false;
  }

  ThemeMode getThemeMode() {
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  void changeTheme() {
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeData(!isSavedDarkMode());
  }
}
