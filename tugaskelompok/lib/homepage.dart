import 'package:flutter/material.dart';
import 'package:tugaskelompok/jenisbilangan.dart';
import 'package:tugaskelompok/konversiwaktu.dart';
import 'package:tugaskelompok/situsrekomendasi.dart';
import 'package:tugaskelompok/trackinglbs.dart';
import 'stopwatch.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void navigate(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("H O M E P A G E"), backgroundColor: Colors.blue[900]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)  => StopwatchPage())), child: Text("Stopwatch")),
            ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)  => NumberTypePage())), child: Text("Jenis Bilangan")),
            ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)  => TrackingLBSPage())), child: Text("Tracking LBS")),
            ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)  => KonversiWaktuPage())), child: Text("Konversi Waktu")),
            ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)  => SitusRekomendasi())), child: Text("Situs Rekomendasi")),
            ElevatedButton(onPressed: () => navigate(context, '/favorite'), child: Text("Favorite")),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // default ke Home
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
}