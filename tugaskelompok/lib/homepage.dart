import 'package:flutter/material.dart';
import 'package:tugaskelompok/jenisbilangan.dart';
import 'package:tugaskelompok/konversiwaktu.dart';
import 'package:tugaskelompok/situsrekomendasi.dart';
import 'package:tugaskelompok/trackinglbs.dart';
import 'stopwatch.dart';
// import 'package:tugaskelompok/loginpage.dart';
// import 'package:tugaskelompok/session.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // void _logout(BuildContext context) async {
  //   await SessionManager.clearLoginSession();
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => LoginPage()),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.logout),
      //       onPressed: () => _logout(context),
      //     )
      //   ],
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Header section with style similar to login page
              Text(
                'Homepage',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pilih fitur yang tersedia',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 40),

              // Menu buttons with style similar to login button
              Expanded(
                child: ListView(
                  children: [
                    _buildMenuButton(
                      context: context,
                      title: 'Stopwatch',
                      icon: Icons.timer,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StopwatchPage()),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildMenuButton(
                      context: context,
                      title: 'Jenis Bilangan',
                      icon: Icons.format_list_numbered,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NumberTypePage()),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildMenuButton(
                      context: context,
                      title: 'Tracking LBS',
                      icon: Icons.location_on,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TrackingLBSPage()),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildMenuButton(
                      context: context,
                      title: 'Konversi Waktu',
                      icon: Icons.access_time,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => KonversiWaktuPage()),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildMenuButton(
                      context: context,
                      title: 'Situs Rekomendasi',
                      icon: Icons.star,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SitusRekomendasi()),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // default ke Home
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
              Navigator.pushReplacementNamed(context, '/help');
              break;
          }
        },
      ),
    );
  }

  Widget _buildMenuButton({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 28,
                color: Colors.blue[700],
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[600],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
