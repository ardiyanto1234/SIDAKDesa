import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormAbsensiPage extends StatefulWidget {
  final File imageFile;

  const FormAbsensiPage({super.key, required this.imageFile});

  @override
  State<FormAbsensiPage> createState() => _FormAbsensiPageState();
}

class _FormAbsensiPageState extends State<FormAbsensiPage> {
  Position? _currentPosition;

  final _namaController = TextEditingController();
  final _tanggalController = TextEditingController();
  final _jamDatangController = TextEditingController();
  final _keteranganController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();

    final now = DateTime.now();
    final dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
    final timeFormat = DateFormat('HH:mm');

    _tanggalController.text = dateFormat.format(now);
    _jamDatangController.text = timeFormat.format(now);
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
    });
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text("$label :", style: const TextStyle(fontSize: 16)),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFF00796B),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.orange, width: 2),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmit() async {
    String nama = _namaController.text.trim();
    String tanggal = _tanggalController.text.trim();
    String jam = _jamDatangController.text.trim();
    String keterangan = _keteranganController.text.trim();

    if (nama.isEmpty || keterangan.isEmpty) {
      // Tampilkan dialog kalau ada field kosong
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text("Peringatan"),
              content: const Text("Nama dan Keterangan wajib diisi!"),
              actions: [
                TextButton(
                  child: const Text("Tutup"),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
      );
      return;
    }

    // Tampilkan dialog konfirmasi
    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text(
            "Apakah data yang anda masukkan sudah benar?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Tidak"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Ya"),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    try {
      await FirebaseFirestore.instance.collection('absensi').add({
        'nama': nama,
        'tanggal': tanggal,
        'jam': jam,
        'keterangan': keterangan,
        'lokasi': {
          'latitude': _currentPosition?.latitude,
          'longitude': _currentPosition?.longitude,
        },
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Setelah berhasil simpan, tampilkan dialog sukses
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              content: const Text("Data absensi berhasil disimpan!"),
              actions: [
                TextButton(
                  child: const Text("Oke"),
                  onPressed:
                      () =>
                          Navigator.popUntil(context, (route) => route.isFirst),
                ),
              ],
            ),
      );
    } catch (e) {
      // Tampilkan dialog error
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text("Gagal"),
              content: Text("Gagal menyimpan data: $e"),
              actions: [
                TextButton(
                  child: const Text("Tutup"),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
      );
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _tanggalController.dispose();
    _jamDatangController.dispose();
    _keteranganController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Absensi"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(label: "Nama", controller: _namaController),
            _buildTextField(
              label: "Tanggal",
              controller: _tanggalController,
              readOnly: true,
            ),
            _buildTextField(
              label: "Datang",
              controller: _jamDatangController,
              readOnly: true,
            ),
            _buildTextField(
              label: "Keterangan",
              controller: _keteranganController,
            ),
            const SizedBox(height: 16),
            const Text("Lokasi :", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            _currentPosition != null
                ? SizedBox(
                  height: 200,
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(
                        _currentPosition!.latitude,
                        _currentPosition!.longitude,
                      ),
                      zoom: 15.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: const ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: LatLng(
                              _currentPosition!.latitude,
                              _currentPosition!.longitude,
                            ),
                            child: const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
                : const Center(child: Text("Memuat lokasi...")),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 52,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  "Kirim",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
