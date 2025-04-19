import 'package:flutter/material.dart';

class KonversiWaktuPage extends StatefulWidget {
  const KonversiWaktuPage({super.key});

  @override
  State<KonversiWaktuPage> createState() => _KonversiWaktuPageState();
}

class _KonversiWaktuPageState extends State<KonversiWaktuPage> {
  final TextEditingController _tahunController = TextEditingController();
  Map<String, String> _hasil = {
    'tahun': '0',
    'jam': '0',
    'menit': '0',
    'detik': '0',
  };
  bool hasConverted = false;

  void _konversiWaktu() {
    double tahun = double.tryParse(_tahunController.text) ?? 0;

    double totalDetik = tahun * 365 * 24 * 60 * 60; // diasumsikan 1 tahun = 365 hari
    int totalJam = (tahun * 365 * 24).floor();
    int totalMenit = (tahun * 365 * 24 * 60).floor();
    int totalDetikInt = totalDetik.floor();

    setState(() {
      _hasil = {
        'tahun': tahun.toString(),
        'jam': totalJam.toString(),
        'menit': totalMenit.toString(),
        'detik': totalDetikInt.toString(),
      };
      hasConverted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F8FF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.blue[600]),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Konversi Waktu',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[600],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Konversi tahun ke berbagai satuan waktu',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(height: 20),
            
            // Input Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.blue[600], size: 20),
                      SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _tahunController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                          decoration: InputDecoration(
                            hintText: "Masukkan jumlah tahun",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey[400], size: 20),
                        onPressed: () {
                          _tahunController.clear();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 24),
            
            // Tombol Konversi
            Center(
              child: Container(
                width: 180,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: _konversiWaktu,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.timer, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text(
                            "Konversi",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 24),
            
            // Hasil Konversi
            if (hasConverted)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Hasil Konversi",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[600],
                            ),
                          ),
                        ),
                        // Menggunakan ListView untuk mengatasi overflow
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            children: [
                              _buildResultItem(
                                icon: Icons.calendar_today,
                                label: "Tahun",
                                value: _hasil['tahun']!,
                                unit: "tahun",
                                iconColor: Colors.green[600]!,
                                bgColor: Colors.green[50]!,
                              ),
                              _buildResultItem(
                                icon: Icons.access_time,
                                label: "Jam",
                                value: _hasil['jam']!,
                                unit: "jam",
                                iconColor: Colors.orange[600]!,
                                bgColor: Colors.orange[50]!,
                              ),
                              _buildResultItem(
                                icon: Icons.timer,
                                label: "Menit",
                                value: _hasil['menit']!,
                                unit: "menit",
                                iconColor: Colors.purple[600]!,
                                bgColor: Colors.purple[50]!,
                              ),
                              _buildResultItem(
                                icon: Icons.timer_10,
                                label: "Detik",
                                value: _hasil['detik']!,
                                unit: "detik",
                                iconColor: Colors.red[600]!,
                                bgColor: Colors.red[50]!,
                              ),
                              // Tambahkan padding di bawah untuk memastikan semua item terlihat
                              SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultItem({
    required IconData icon,
    required String label,
    required String value,
    required String unit,
    required Color iconColor,
    required Color bgColor,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    unit,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
