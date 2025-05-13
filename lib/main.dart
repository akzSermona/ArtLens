import 'package:flutter/material.dart';
import 'package:artlens/screens/home_screen.dart';

final customColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF84A98C),
  onPrimary: Colors.black,
  secondary: Color.fromRGBO(82, 121, 111, 1),
  onSecondary: Colors.white,
  surface: Color(0xFFCAD2C5),
  onSurface: Colors.black,
  error: Colors.red,
  onError: Colors.white,
);

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: customColorScheme),
      home: const HomeScreen(),
    ),
  );
}
