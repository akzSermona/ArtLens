import 'dart:io';
import 'package:artlens/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onImageSelected});

  final void Function(File image) onImageSelected;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _selectImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: source,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _selectedImage = File(pickedImage.path);
    });
    widget.onImageSelected(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 300,
          child: ElevatedButton.icon(
            onPressed: () => _selectImage(ImageSource.camera),
            icon: const Icon(Icons.camera_alt),
            label: Text(
              'Scatta una foto',
              style: TextStyle(
                fontFamily: 'RobotoCondensed',
                color: customColorScheme.onPrimary,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
              backgroundColor: customColorScheme.primary,
              iconColor: customColorScheme.onPrimary,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 300,
          child: ElevatedButton.icon(
            onPressed: () => _selectImage(ImageSource.gallery),
            icon: const Icon(Icons.photo_library),
            label: Text(
              'Scegli dalla galleria',
              style: TextStyle(
                fontFamily: 'RobotoCondensed',
                color: customColorScheme.onPrimary,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
              backgroundColor: customColorScheme.primary,
              iconColor: customColorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
