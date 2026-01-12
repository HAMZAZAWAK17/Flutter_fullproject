import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  Uint8List? imageBytes;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() {
          imageBytes = bytes;
        });
      }
    } catch (e) {
      print('Erreur lors de la sélection de l\'image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images Asset, Network et Memory'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Image Asset',
                  style: TextStyle(fontSize: 40, color: Colors.green),
                ),
                SizedBox(height: 30),
                Image.asset(
                  'assets/imageassets.jpeg',
                  width: 300,
                  height: 300,
                ),
                SizedBox(height: 30),
                Text(
                  'Image Network',
                  style: TextStyle(fontSize: 40, color: Colors.green),
                ),
                SizedBox(height: 30),
                Image.network(
                  'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                  width: 300,
                  height: 150,
                ),
                SizedBox(height: 30),
                Text(
                  'Image Memory',
                  style: TextStyle(fontSize: 40, color: Colors.green),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: pickImageFromGallery,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(
                    'Sélectionner une image',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: 30),
                imageBytes != null
                    ? Image.memory(
                        imageBytes!,
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Aucune image sélectionnée',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
