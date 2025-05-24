import 'package:artlens/main.dart';
import 'package:artlens/models/artwork.dart';
import 'package:flutter/material.dart';
import 'package:artlens/screens/history_screen.dart';
import 'package:artlens/screens/saved_screen.dart';
import 'package:artlens/screens/scan_screen.dart';
import 'package:artlens/db/artwork_db.dart';
import 'package:artlens/widgets/home/latest_artwork.dart';
import 'package:artlens/widgets/home/home_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Artwork> _latestArtworks = [];

  @override
  void initState() {
    super.initState();
    _loadLatestArtworks();
  }

  Future<void> _loadLatestArtworks() async {
    final artworks = await ArtworkDb.instance.getAllArtworks();
    setState(() {
      _latestArtworks = artworks.take(1).toList();
    });
  }

  Widget buildButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.translate(
          offset: const Offset(0, 50),
          child: HomeCircleButton(
            context: context,
            icon: Icons.camera_alt_outlined,
            destinationPage: const ScanScreen(),
            padding: 40,
            iconSize: 30,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeCircleButton(
              context: context,
              icon: Icons.history_outlined,
              destinationPage: const HistoryScreen(),
              padding: 30,
              iconSize: 24,
            ),
            const SizedBox(width: 40),
            HomeCircleButton(
              context: context,
              icon: Icons.bookmark_outlined,
              destinationPage: const SavedScreen(),
              padding: 30,
              iconSize: 24,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'ArtLens',
          style: TextStyle(fontFamily: 'Limelight', fontSize: 25.r),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
            'Ogni opera ha una sua storia: SCOPRIAMOLA INSIEME!',
            style: TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: 15.r,
              color: customColorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Le tue ultime opere scansionate:',
                    style: TextStyle(
                      fontFamily: 'RobotoCondensed',
                      fontSize: 17.r,
                      color: customColorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
                  LatestArtworkCards(artworks: _latestArtworks),
                  buildButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
