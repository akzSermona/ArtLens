import 'package:artlens/main.dart';
import 'package:artlens/models/artwork.dart';
import 'package:flutter/material.dart';
import 'package:artlens/screens/history_screen.dart';
import 'package:artlens/screens/saved_screen.dart';
import 'package:artlens/screens/scan_screen.dart';
import 'package:artlens/db/artwork_db.dart';
import 'package:artlens/widgets/artwork_list/artwork_item.dart';

//TODO non far uscire arrowback quando si è nella home
// adattare la home ai vari dispositivi
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

  Widget buildLatestArtworksCards() {
    if (_latestArtworks.isEmpty) {
      return const SizedBox();
    }
    return Column(
      children:
          _latestArtworks
              .map(
                (artwork) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 5.0,
                  ),
                  child: ArtworkItem(artwork),
                ),
              )
              .toList(),
    );
  }

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
          offset: const Offset(0, 50),
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
            const SizedBox(width: 40),
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
        automaticallyImplyLeading: false,
        title: const Text(
          'ArtLens',
          style: TextStyle(fontFamily: 'Limelight', fontSize: 25),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          Text(
            'Le tue ultime opere scansionate:',
            style: TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: 17,
              color: customColorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          buildLatestArtworksCards(),
          mainContent,
        ],
      ),
    );
  }
}
