import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatelessWidget {
  final void Function(File) onImageSelected;

  const ImageInput({super.key, required this.onImageSelected});

  Future<void> _selectImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source, maxWidth: 600);

    if (pickedImage == null) return;

    final imageFile = File(pickedImage.path);
    onImageSelected(imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 300,
          child: ElevatedButton.icon(
            onPressed: () => _selectImage(context, ImageSource.camera),
            icon: const Icon(Icons.camera_alt),
            label: const Text('Scatta una foto'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 300,
          child: ElevatedButton.icon(
            onPressed: () => _selectImage(context, ImageSource.gallery),
            icon: const Icon(Icons.photo_library),
            label: const Text('Scegli dalla galleria'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
          ),
        ),
      ],
    );
  }
}
