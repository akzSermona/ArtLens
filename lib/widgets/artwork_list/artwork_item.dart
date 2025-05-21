import 'dart:io';
import 'package:artlens/main.dart';
import 'package:flutter/material.dart';
import 'package:artlens/models/artwork.dart';
import 'package:artlens/providers/user_favorites_provider.dart';
import 'package:artlens/db/artwork_db.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArtworkItem extends ConsumerStatefulWidget {
  const ArtworkItem(this.artwork, {super.key});

  final Artwork artwork;

  @override
  ConsumerState<ArtworkItem> createState() => _ArtworkItemState();
}

class _ArtworkItemState extends ConsumerState<ArtworkItem> {
  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoritesProvider);
    final isFavorite = favorites.any((a) => a.id == widget.artwork.id);

    return Card(
      color: customColorScheme.primary,
      elevation: 10,
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: customColorScheme.primary,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child:
                      widget.artwork.imagePath.isNotEmpty
                          ? Image.file(
                            File(widget.artwork.imagePath),
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          )
                          : const SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Icon(
                              Icons.image,
                              size: 60,
                              color: Colors.grey,
                            ),
                          ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.artwork.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFFCAD2C5),
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  widget.artwork.artist,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFFCAD2C5),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 8,
            right: 8,
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.bookmark : Icons.bookmark_add_outlined,
                color: Colors.yellow,
                size: 28,
              ),
              onPressed: () async {
                final notifier = ref.read(favoritesProvider.notifier);

                if (isFavorite) {
                  notifier.removeFromFavorites(widget.artwork);
                  await ArtworkDb.instance.removeFromFavorites(
                    widget.artwork.id,
                  );
                } else {
                  notifier.addToFavorites(widget.artwork);
                  await ArtworkDb.instance.addToFavorites(widget.artwork.id);
                }
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
