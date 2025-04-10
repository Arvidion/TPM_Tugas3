import 'package:flutter/material.dart';

class KonversiWaktuPage extends StatefulWidget {
  const KonversiWaktuPage({super.key});

  @override
  State<KonversiWaktuPage> createState() => _KonversiWaktuPageState();
}

class _KonversiWaktuPageState extends State<KonversiWaktuPage> {
  final TextEditingController _tahunController = TextEditingController();
  String _hasil = "";

  void _konversiWaktu() {
    double tahun = double.tryParse(_tahunController.text) ?? 0;

    double totalDetik = tahun * 365 * 24 * 60 * 60; // diasumsikan 1 tahun = 365 hari
    int totalJam = (totalDetik / 3600).floor();
    int totalMenit = (totalDetik / 60).floor();
    int totalDetikInt = totalDetik.floor();

    setState(() {
      _hasil = '''
      Tahun: $tahun
      Jam   : $totalJam jam
      Menit : $totalMenit menit
      Detik : $totalDetikInt detik
      ''';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Konversi Waktu")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _tahunController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Masukkan jumlah tahun",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _konversiWaktu,
              icon: Icon(Icons.timer),
              label: Text("Konversi"),
            ),
            SizedBox(height: 30),
            Text(
              _hasil,
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
