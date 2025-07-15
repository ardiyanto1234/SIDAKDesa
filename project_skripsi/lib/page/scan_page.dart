import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_skripsi/page/pengisianAbsensi_page.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  // ignore: unused_field
  File? _capturedImage;

  Future<void> _takePicture() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      setState(() {
        _capturedImage = imageFile;
      });

      // Pindah ke halaman pengisian absensi
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FormAbsensiPage(imageFile: imageFile),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ambil Foto untuk Absensi'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: _takePicture,
          icon: Icon(Icons.camera_alt),
          label: Text('Ambil Foto'),
        ),
      ),
    );
  }
}
