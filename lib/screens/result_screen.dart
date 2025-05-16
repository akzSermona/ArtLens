import 'dart:io';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final File image;

  const ResultScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Risultato Scansione:',
          style: TextStyle(fontFamily: 'Limelight', fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Center(child: Image.file(image)),
    );
  }
}
