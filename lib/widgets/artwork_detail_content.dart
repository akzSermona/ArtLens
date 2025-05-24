import 'dart:io';
import 'package:artlens/main.dart';
import 'package:flutter/material.dart';
import 'package:artlens/models/artwork.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArtworkDetailContent extends StatelessWidget {
  final Artwork artwork;

  const ArtworkDetailContent({super.key, required this.artwork});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: customColorScheme.primary, width: 10),
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAlias,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:
                artwork.imagePath.isNotEmpty
                    ? Image.file(
                      File(artwork.imagePath),
                      height: 250.r,
                      fit: BoxFit.cover,
                    )
                    : const Icon(Icons.image, size: 250),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          artwork.title,
          style: TextStyle(fontSize: 24.r, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: 'Artista: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: artwork.artist),
            ],
            style: TextStyle(fontSize: 18.r),
          ),
        ),
        if (artwork.date.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Data: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: artwork.date),
              ],
            ),
          ),
        ],
        if (artwork.description.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Descrizione: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: artwork.description),
              ],
            ),
          ),
        ],
        if (artwork.informationLink.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Approfondisci: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: artwork.informationLink),
              ],
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        ],
        const SizedBox(height: 16),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: 'Luogo: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: artwork.location.address),
            ],
          ),
        ),
      ],
    );
  }
}
