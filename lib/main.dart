import 'package:artlens/db/artwork_db.dart';
import 'package:flutter/material.dart';
import 'package:artlens/screens/home_screen.dart';

final customColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: Color.fromARGB(255, 255, 255, 255),
  primary: Color(0xFF354F52),
  onPrimary: Color(0xFFCAD2C5),
  surface: Color(0xFFCAD2C5),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ArtworkDb.instance.database;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: customColorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: customColorScheme.primary,
          titleTextStyle: TextStyle(
            fontFamily: 'Limelight',
            fontSize: 20,
            color: customColorScheme.onPrimary,
          ),
          iconTheme: IconThemeData(color: customColorScheme.onPrimary),
        ),
      ),
      home: const HomeScreen(),
    ),
  );
}
