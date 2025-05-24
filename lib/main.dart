import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artlens/db/artwork_db.dart';
import 'package:artlens/screens/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final customColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: const Color.fromARGB(255, 255, 255, 255),
  primary: const Color(0xFF354F52),
  onPrimary: const Color(0xFFCAD2C5),
  surface: const Color(0xFFCAD2C5),
);

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ArtworkDb.instance.database;
  runApp(const ProviderScope(child: ArtlensApp()));
}

class ArtlensApp extends StatelessWidget {
  const ArtlensApp({super.key});

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    splitScreenMode: true,
    builder:
        (context, child) => MaterialApp(
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
          home: child,
        ),
    child: const HomeScreen(),
  );
}
