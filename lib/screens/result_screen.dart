import 'dart:io';
import 'package:artlens/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artlens/db/artwork_db.dart';
import 'package:artlens/models/artwork.dart';
import 'package:artlens/providers/user_favorites_provider.dart';

class ResultScreen extends ConsumerStatefulWidget {
  final File image;
  final String artworkId;

  const ResultScreen({super.key, required this.image, required this.artworkId});

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  bool _isBookmarkDisabled = false;

  Future<void> _addToFavoritesWithUndo() async {
    setState(() => _isBookmarkDisabled = true);

    // Aggiorna il DB
    await ArtworkDb.instance.addToFavorites(widget.artworkId);

    // Recupera l'opera dal DB per aggiornarla nel provider (assumendo che esista)
    final allArtworks = await ArtworkDb.instance.getAllArtworks();
    final artwork = allArtworks.firstWhere(
      (a) => a.id == widget.artworkId,
      orElse: () => throw Exception('Artwork non trovato'),
    );

    // Aggiorna il provider Riverpod
    ref.read(favoritesProvider.notifier).addToFavorites(artwork);

    // Mostra Snackbar con undo
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Aggiunto ai preferiti!'),
        action: SnackBarAction(
          label: 'Annulla',
          onPressed: () async {
            // Rimuovi da DB
            await ArtworkDb.instance.removeFromFavorites(widget.artworkId);
            // Rimuovi da provider
            ref.read(favoritesProvider.notifier).removeFromFavorites(artwork);
            // Riabilita il bottone
            setState(() => _isBookmarkDisabled = false);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Risultato Scansione:',
          style: TextStyle(fontFamily: 'Limelight', fontSize: 18),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_add_outlined),
            onPressed: _isBookmarkDisabled ? null : _addToFavoritesWithUndo,
          ),
        ],
      ),
      body: Center(child: Image.file(widget.image)),
    );
  }
}
