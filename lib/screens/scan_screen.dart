import 'package:flutter/material.dart';
import 'dart:io';

import 'package:artlens/screens/result_screen.dart';
import 'package:artlens/widgets/image_input.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  void _onImageSelected(BuildContext context, File image) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => ResultScreen(image: image)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scannerizza ora!',
          style: TextStyle(fontFamily: 'Limelight', fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Seleziona il metodo con cui vuoi scannerizzare:',
              style: TextStyle(fontFamily: 'Limelight', fontSize: 17),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ImageInput(
              onImageSelected: (image) => _onImageSelected(context, image),
            ),
          ],
        ),
      ),
    );
  }
}
