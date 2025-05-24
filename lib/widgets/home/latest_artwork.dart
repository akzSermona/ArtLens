import 'package:flutter/material.dart';
import 'package:artlens/models/artwork.dart';
import 'package:artlens/widgets/artwork_list/artwork_item.dart';

class LatestArtworkCards extends StatelessWidget {
  final List<Artwork> artworks;

  const LatestArtworkCards({super.key, required this.artworks});

  @override
  Widget build(BuildContext context) {
    if (artworks.isEmpty) {
      return const SizedBox();
    }
    return Column(
      children:
          artworks
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
}
