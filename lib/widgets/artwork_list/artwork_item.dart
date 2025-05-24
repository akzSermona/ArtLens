import 'dart:io';
import 'package:artlens/main.dart';
import 'package:artlens/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:artlens/models/artwork.dart';
import 'package:artlens/providers/user_favorites_provider.dart';
import 'package:artlens/db/artwork_db.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArtworkItem extends ConsumerStatefulWidget {
  const ArtworkItem(this.artwork, {super.key, this.margin});

  final Artwork artwork;
  final EdgeInsetsGeometry? margin;

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
      margin:
          widget.margin ??
          EdgeInsets.symmetric(vertical: 15.r, horizontal: 15.r),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(artworkId: widget.artwork.id),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child:
                  widget.artwork.imagePath.isNotEmpty
                      ? Image.file(
                        File(widget.artwork.imagePath),
                        height: 150.r,
                        width: double.infinity.r,
                        fit: BoxFit.cover,
                      )
                      : Container(
                        height: 150.r,
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.image,
                          size: 60,
                          color: Colors.grey,
                        ),
                      ),
            ),
            ListTile(
              title: Text(
                widget.artwork.title,
                style: TextStyle(
                  fontSize: 20.r,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFCAD2C5),
                ),
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                widget.artwork.artist,
                style: TextStyle(
                  fontSize: 17.r,
                  color: const Color(0xFFCAD2C5),
                ),
                textAlign: TextAlign.center,
              ),
              trailing: IconButton(
                icon: Icon(
                  isFavorite ? Icons.bookmark : Icons.bookmark_add_outlined,
                  color: const Color(0xFFCAD2C5),
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
                tooltip:
                    isFavorite
                        ? 'Rimuovi dai preferiti'
                        : 'Aggiungi ai preferiti',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
