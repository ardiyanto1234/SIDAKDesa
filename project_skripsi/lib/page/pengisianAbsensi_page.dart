import 'dart:io';
import 'package:flutter/material.dart';

class FormAbsensiPage extends StatelessWidget {
  final File imageFile;

  const FormAbsensiPage({Key? key, required this.imageFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _namaController = TextEditingController();
    final _keteranganController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Form Absensi'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Foto yang diambil:', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Image.file(imageFile, width: double.infinity, height: 250, fit: BoxFit.cover),
            SizedBox(height: 20),

            TextField(
              controller: _namaController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _keteranganController,
              decoration: InputDecoration(labelText: 'Keterangan'),
            ),
            SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Simpan data absensi, kirim ke backend, dsb
                  String nama = _namaController.text;
                  String keterangan = _keteranganController.text;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Absensi Terkirim:\n$nama - $keterangan')),
                  );

                  Navigator.pop(context);
                },
                child: Text('Kirim Absensi'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
