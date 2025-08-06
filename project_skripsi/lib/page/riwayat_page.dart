import 'package:flutter/material.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> dataRiwayat = [
      {
        'jenis': 'Hadir',
        'tanggal': '10 Juli 2025',
        'jam': '08:00 - 12.00',
        'icon': 'assets/images/icon_masuk.png',
      },
      {
        'jenis': 'Izin',
        'tanggal': '10 Juli 2025',
        'jam': '08:00 - 12.00',
        'icon': 'assets/images/izin.png',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Riwayat',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF007B7F),
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: dataRiwayat.length,
          separatorBuilder: (context, index) => const Divider(thickness: 1),
          itemBuilder: (context, index) {
            final item = dataRiwayat[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Image.asset(
                  item['icon']!,
                  width: 40,
                  height: 40,
                ),
                const SizedBox(width: 12),

                // Teks (jenis & jam)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['jenis']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['jam']!,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF007B7F),
                        ),
                      ),
                    ],
                  ),
                ),

                // Tanggal di kanan atas
                Text(
                  item['tanggal']!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF007B7F),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}