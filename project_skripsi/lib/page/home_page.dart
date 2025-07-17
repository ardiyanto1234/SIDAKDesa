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
      final doc =
          await FirebaseFirestore.instance
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
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.teal,
                  child: Icon(Icons.person, color: Colors.white, size: 30),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Selamat Datang 👋",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.notifications_none),
              ],
            ),
            const SizedBox(height: 24),

            // Card "Sudah absen hari ini?"
            const HariIniCard(),
            const SizedBox(height: 24),

            // Tombol Izin dan Riwayat
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Aksi izin
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.teal, width: 1.5),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/icon_izin.png',
                            height: 60,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Izin',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Aksi riwayat
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      margin: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.teal, width: 1.5),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/icon_riwayat.png',
                            height: 60,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Riwayat',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Info Hari Ini
            const Text(
              'Info hari ini',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Container keseluruhan
            Container(
              child: Column(
                children: [
                  // Datang
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/icon_masuk.png',
                          width: 32,
                          height: 32,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Datang',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '08:00 wib',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF007F76),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Garis pembatas
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Divider(
                      thickness: 1,
                      height: 1,
                      color: Colors.black,
                    ),
                  ),

                  // Pulang
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/icon_masuk.png',
                          width: 32,
                          height: 32,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Pulang',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '12:00 wib',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF007F76),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget: HariIniCard
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
                  'Sudah absen hari ini?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Ayo laporkan kegiatanmu hari ini!',
                  style: TextStyle(fontSize: 16, color: Color(0xFF007F76)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
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

// Widget: RiwayatItem
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
      leading: Image.asset(imageAsset, width: 32, height: 32),
      title: Text(status),
      subtitle: Text(time),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
    );
  }
}
