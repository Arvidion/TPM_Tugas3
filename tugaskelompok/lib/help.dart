import 'package:flutter/material.dart';
import 'package:tugaskelompok/loginpage.dart';
import 'package:tugaskelompok/session.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  void _logout(BuildContext context) async {
    await SessionManager.clearLoginSession();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // FAQ items with questions and answers
    final List<Map<String, String>> faqItems = [
      {
        'question': 'Cara menggunakan Stopwatch?',
        'answer':
            'Buka menu Stopwatch dari halaman utama, lalu tekan tombol "Start" untuk memulai penghitungan waktu. Tekan "Stop" untuk menghentikan dan "Reset" untuk mengatur ulang waktu.'
      },
      {
        'question': 'Apa itu fitur Jenis Bilangan?',
        'answer':
            'Fitur Jenis Bilangan memungkinkan Anda untuk mengidentifikasi jenis bilangan seperti bilangan prima, ganjil, genap, dan lainnya dari angka yang Anda masukkan.'
      },
      {
        'question': 'Bagaimana cara menggunakan Tracking LBS?',
        'answer':
            'Buka menu Tracking LBS, izinkan akses lokasi pada perangkat Anda, dan aplikasi akan menampilkan lokasi Anda saat ini pada peta.'
      },
      {
        'question': 'Cara melakukan Konversi Waktu?',
        'answer':
            'Masukkan waktu yang ingin dikonversi, pilih jenis konversi yang diinginkan (seperti dari Menit ke Jam), lalu tekan tombol "Konversi" untuk mendapatkan hasilnya.'
      },
      {
        'question': 'Apa itu Situs Rekomendasi?',
        'answer':
            'Situs Rekomendasi adalah fitur yang menyediakan daftar situs web pilihan yang bermanfaat sesuai dengan kategori yang tersedia.'
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Header section with style similar to homepage and logout button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bantuan',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Text(
                      //   'Pertanyaan dan informasi bantuan',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     color: Colors.grey[600],
                      //   ),
                      // ),
                    ],
                  ),
                  // Logout button
                  ElevatedButton.icon(
                    onPressed: () => _logout(context),
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD54F),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Welcome card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 24,
                            color: Colors.blue[700],
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Selamat Datang',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Selamat datang di aplikasi kami! Gunakan menu di halaman utama untuk mengakses berbagai fitur yang tersedia. Jika butuh bantuan lebih lanjut, silakan hubungi tim pengembang.",
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
              Text(
                'FAQ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
              const SizedBox(height: 16),

              // FAQ list
              Expanded(
                child: ListView.builder(
                  itemCount: faqItems.length,
                  itemBuilder: (context, index) {
                    return _buildFaqItem(
                      faqItems[index]['question']!,
                      faqItems[index]['answer']!,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Selected tab is Bantuan
        selectedItemColor: Colors.blue[700],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Utama'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Anggota'),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Bantuan'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/members');
              break;
            case 2:
              // Already on help page
              break;
          }
        },
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        expandedAlignment: Alignment.topLeft,
        childrenPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        title: Text(
          question,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Icon(
          Icons.help_outline,
          color: Colors.blue[700],
        ),
        children: [
          Text(
            answer,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
