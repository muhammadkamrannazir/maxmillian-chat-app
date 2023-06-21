import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _imagesPicker;
  @override
  Widget build(BuildContext context) {
    void pickImage() async {
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 150,
      );
      setState(() {
        _imagesPicker = File(pickedImage!.path);
      });
    }

    return Column(
      children: [
         CircleAvatar(
          radius: 14,
          backgroundColor: Colors.grey,
          backgroundImage: FileImage(_imagesPicker!)
         ),
        TextButton.icon(
          onPressed: pickImage,
          icon: const Icon(Icons.image),
          label: Text(
            'Add Image',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
