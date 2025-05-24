import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artlens/models/artwork.dart';
import 'package:artlens/widgets/artwork_detail_content.dart';
import 'package:artlens/db/artwork_db.dart';
import 'package:artlens/providers/user_favorites_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailScreen extends ConsumerStatefulWidget {
  final String artworkId;

  const DetailScreen({super.key, required this.artworkId});

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  late Future<Artwork> _artworkFuture;
  bool _isBookmarkDisabled = false;

  @override
  void initState() {
    super.initState();
    _artworkFuture = ArtworkDb.instance.getArtworkById(widget.artworkId);
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    final favorites = await ArtworkDb.instance.getFavorites();
    final isAlreadyFavorite = favorites.any((a) => a.id == widget.artworkId);
    if (mounted) {
      setState(() {
        _isBookmarkDisabled = isAlreadyFavorite;
      });
    }
  }

  Future<void> _addToFavoritesWithUndo(Artwork artwork) async {
    setState(() => _isBookmarkDisabled = true);
    await ArtworkDb.instance.addToFavorites(artwork.id);
    ref.read(favoritesProvider.notifier).addToFavorites(artwork);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Aggiunto ai preferiti!'),
        action: SnackBarAction(
          label: 'Annulla',
          onPressed: () async {
            await ArtworkDb.instance.removeFromFavorites(artwork.id);
            ref.read(favoritesProvider.notifier).removeFromFavorites(artwork);
            setState(() => _isBookmarkDisabled = false);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Artwork>(
      future: _artworkFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: Text('Opera non trovata')));
        }

        final artwork = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Dettagli scansione',
              style: TextStyle(fontFamily: 'Limelight', fontSize: 20.r),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.bookmark_add_outlined),
                onPressed:
                    _isBookmarkDisabled
                        ? null
                        : () => _addToFavoritesWithUndo(artwork),
              ),
            ],
          ),
          body: ArtworkDetailContent(artwork: artwork),
        );
      },
    );
  }
}
