import 'package:artlens/main.dart';
import 'package:flutter/material.dart';
import 'package:artlens/screens/history_screen.dart';
import 'package:artlens/screens/saved_screen.dart';
import 'package:artlens/screens/scan_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Widget buildSideButton(
      BuildContext context,
      IconData icon,
      Widget destinationPage,
    ) {
      return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destinationPage),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(30),
          backgroundColor: customColorScheme.primary,
        ),
        child: Icon(icon, size: 24, color: customColorScheme.onPrimary),
      );
    }

    Widget buildCenterButton(IconData icon) {
      return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScanScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(40),
          backgroundColor: customColorScheme.primary,
        ),
        child: Icon(icon, size: 30, color: customColorScheme.onPrimary),
      );
    }

    Widget mainContent = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.translate(
          offset: const Offset(0, 40),
          child: buildCenterButton(Icons.camera_alt_outlined),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildSideButton(
              context,
              Icons.history_outlined,
              const HistoryScreen(),
            ),
            const SizedBox(width: 45),
            buildSideButton(
              context,
              Icons.bookmark_outlined,
              const SavedScreen(),
            ),
          ],
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ArtLens',
          style: TextStyle(fontFamily: 'Limelight', fontSize: 25),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Ogni opera ha una storia: SCOPRIAMOLA INSIEME!',
            style: TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: 17,
              color: customColorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 320),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
