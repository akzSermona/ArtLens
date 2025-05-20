import 'package:flutter/material.dart';
import 'package:artlens/models/artwork.dart';
import 'package:artlens/widgets/artwork_list/artwork_item.dart';

class ArtworkList extends StatelessWidget {
  const ArtworkList({
    super.key,
    required this.artworks,
    required this.showOnlyFavorites,
  });

  final List<Artwork> artworks;
  final bool showOnlyFavorites;

  @override
  Widget build(BuildContext context) {
    final displayedArtworks =
        showOnlyFavorites
            ? artworks.where((artwork) => artwork.isFavorite).toList()
            : artworks;

    return ListView.builder(
      itemCount: displayedArtworks.length,
      itemBuilder: (ctx, index) => ArtworkItem(displayedArtworks[index]),
    );
  }
}
