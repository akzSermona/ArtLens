import 'package:flutter/material.dart';
import 'package:artlens/screens/home_screen.dart';

final customColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: Color(0xFF84A98C),
  primary: Color(0xFF84A98C),
  surface: Color(0xFFCAD2C5),
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
