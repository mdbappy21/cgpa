import 'package:cgpa/controller_binder.dart';
import 'package:cgpa/presentation/ui/screens/home_screen.dart';
import 'package:cgpa/presentation/ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiuCgpa extends StatefulWidget {
  const DiuCgpa({super.key});

  @override
  State<DiuCgpa> createState() => _DiuCgpaState();
}

class _DiuCgpaState extends State<DiuCgpa> {
  ThemeMode _themeMode = ThemeMode.light;

  void _changeTheme(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(onThemeChanged: _changeTheme),
      initialBinding: ControllerBinder(),
      theme: _lightThemeData(),
      darkTheme: _darkThemeData(),
      themeMode: _themeMode,
    );
  }

  ThemeData _lightThemeData() => ThemeData(
    brightness: Brightness.light,
    inputDecorationTheme: InputDecorationTheme(
      border: _outlineInputBorder(),
      enabledBorder: _outlineInputBorder(AppColors.themeColor1),
      focusedBorder: _outlineInputBorder(AppColors.themeColor2),
      errorBorder: _outlineInputBorder(Colors.red),
      hintStyle: TextStyle(fontWeight: FontWeight.w400),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        fixedSize: Size(double.maxFinite, 50),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade200,
      elevation: 0, // Remove shadow if needed
      centerTitle: true,
    ),
  );

  OutlineInputBorder _outlineInputBorder([Color? color]) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color ?? AppColors.themeColor1, width: 1.2),
      borderRadius: BorderRadius.circular(8),
    );
  }

  ThemeData _darkThemeData() => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.blackTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkButtonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        fixedSize: Size(double.maxFinite, 50),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(

      border: _outlineInputBorder(),
      enabledBorder: _outlineInputBorder(AppColors.themeColor1),
      focusedBorder: _outlineInputBorder(Colors.grey),
      errorBorder: _outlineInputBorder(Colors.red),
      hintStyle: TextStyle(fontWeight: FontWeight.w400),
      labelStyle: TextStyle(color: Colors.white),

    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      titleLarge: TextStyle(color: Colors.black),
      titleMedium: TextStyle(color: Colors.black),
      titleSmall: TextStyle(color: Colors.black),
      labelLarge: TextStyle(color: Colors.black),
      labelMedium: TextStyle(color: Colors.black),
      labelSmall: TextStyle(color: Colors.black),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black38,
      elevation: 0, // Remove shadow if needed
      centerTitle: true,
    ),
  );
}
