import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = 'Memuat...';

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  Future<void> getUserName() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc('wukMPM02lv7PAxRTnS6Q')
          .get();

      if (doc.exists) {
        setState(() {
          userName = doc.data()?['username'] ?? 'Tidak ada nama';
        });
      } else {
        setState(() {
          userName = 'Pengguna tidak ditemukan';
        });
      }
    } catch (e) {
      setState(() {
        userName = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const Icon(Icons.account_circle, size: 50, color: Colors.teal),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Selamat Datang 👋", style: TextStyle(fontSize: 14)),
                    Text(
                      userName,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.notifications_none),
              ],
            ),
            const SizedBox(height: 24),

            // Card "Bagaimana Hari Ini?"
            const HariIniCard(),
            const SizedBox(height: 16),

            // Tombol Izin
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Aksi tombol
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFD8732),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  'Izin',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Riwayat Hari Ini',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // List Riwayat
            Column(
              children: const [
                RiwayatItem(
                  imageAsset: 'assets/images/icon_masuk.png',
                  status: 'Hadir',
                  time: '08:00 - 12.00',
                ),
                RiwayatItem(
                  imageAsset: 'assets/images/icon_masuk.png',
                  status: 'Hadir',
                  time: '08:00 - 12.00',
                ),
                RiwayatItem(
                  imageAsset: 'assets/images/icon_izin.png',
                  status: 'Izin',
                  time: '00:00',
                ),
                RiwayatItem(
                  imageAsset: 'assets/images/icon_masuk.png',
                  status: 'Hadir',
                  time: '08:00 - 12.00',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// =========================
// WIDGET: Card Hari Ini
// =========================
class HariIniCard extends StatelessWidget {
  const HariIniCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF5F1),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Kiri: teks
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Bagaimana hari ini?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Ayo laporkan kegiatanmu hari ini!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF007F76),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // Gambar ilustrasi
          Image.asset(
            'assets/images/banner.png',
            height: 100,
            width: 100,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}

// =========================
// WIDGET: Riwayat Item
// =========================
class RiwayatItem extends StatelessWidget {
  final String imageAsset;
  final String status;
  final String time;

  const RiwayatItem({
    super.key,
    required this.imageAsset,
    required this.status,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        imageAsset,
        width: 32,
        height: 32,
      ),
      title: Text(status),
      subtitle: Text(time),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
    );
  }
}
