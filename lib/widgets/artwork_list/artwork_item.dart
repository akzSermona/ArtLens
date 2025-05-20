import 'package:artlens/main.dart';
import 'package:flutter/material.dart';
import 'package:artlens/models/artwork.dart';
import 'dart:io';

class ArtworkItem extends StatelessWidget {
  const ArtworkItem(this.artwork, {super.key});

  final Artwork artwork;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: customColorScheme.primary,
      elevation: 10,
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: customColorScheme.primary, width: 5),
                borderRadius: BorderRadius.circular(5),
              ),
              clipBehavior: Clip.antiAlias,
              child:
                  artwork.imagePath.isNotEmpty
                      ? Image.file(
                        File(artwork.imagePath),
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      )
                      : const SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: Icon(Icons.image, size: 60, color: Colors.grey),
                      ),
            ),
            const SizedBox(height: 12),
            Text(
              artwork.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFFCAD2C5),
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              artwork.artist,
              style: const TextStyle(fontSize: 15, color: Color(0xFFCAD2C5)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
