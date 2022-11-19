import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  late final Function onSelectImage;
  ImageInput(this.onSelectImage);
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  final ImagePicker imagePicker = ImagePicker();

  Future<void> _takePicture() async {
    final XFile? imageFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 1920,
      maxWidth: 1080,
    );
    if(imageFile == null) return;
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(imageFile.path);
    final saveImage = await _storedImage!.copy('${appDir.path}/$fileName');
    widget.onSelectImage(saveImage);
    print('File dir: ${appDir.path}/$fileName');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage as File,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No image taken',
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            onPressed: _takePicture,
            icon: const Icon(Icons.camera),
            label: const Text('Take picture'),
          ),
        ),
      ],
    );
  }
}
