import 'package:flutter/material.dart';

class NumberTypePage extends StatefulWidget {
  const NumberTypePage({super.key});

  @override
  State<NumberTypePage> createState() => _NumberTypePageState();
}

class _NumberTypePageState extends State<NumberTypePage> {
  final _controller = TextEditingController();
  String _result = '';
  bool _hasResult = false;

  void checkNumberType(String input) {
    if (input.isEmpty) {
      setState(() {
        _result = 'Silakan masukkan angka terlebih dahulu';
        _hasResult = false;
      });
      return;
    }

    double? number = double.tryParse(input);
    if (number == null) {
      setState(() {
        _result = 'Bukan angka valid';
        _hasResult = false;
      });
    } else {
      // Cek Decimal
      bool isDecimal = number % 1 != 0;

      // Konversi ke int untuk pengecekan bilangan bulat
      int intNumber = number.toInt();

      // Cek Prima (hanya untuk bilangan bulat positif > 1)
      bool isPrime = false;
      if (!isDecimal && intNumber > 1) {
        isPrime = true;
        for (int i = 2; i <= intNumber ~/ 2; i++) {
          if (intNumber % i == 0) {
            isPrime = false;
            break;
          }
        }
      }

      // Cek Cacah (bilangan bulat >= 0)
      bool isCacah = !isDecimal && intNumber >= 0;

      // Cek Bulat
      String bulatStatus = 'tidak';
      if (!isDecimal) {
        if (intNumber > 0) {
          bulatStatus = 'ya (positif)';
        } else if (intNumber < 0) {
          bulatStatus = 'ya (negatif)';
        } else {
          bulatStatus = 'ya (nol)'; // angka 0 termasuk cacah dan bulat
        }
      }

      setState(() {
        _result = 'Hasil analisis untuk angka: $number';
        _hasResult = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = const Color(0xFFFCF7FD); // Warna latar belakang yang sama seperti stopwatch

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tombol kembali + judul
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                    color: Colors.blue[700],
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Jenis Bilangan',
                    style: TextStyle(
                      color: Colors.blue[700],
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  'Identifikasi angka dengan tepat',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Input + Tombol Analisis
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: _controller,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                      decoration: InputDecoration(
                        hintText: 'Masukkan angka...',
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(
                          Icons.numbers,
                          color: Colors.blue[700],
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _controller.clear();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => checkNumberType(_controller.text),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Analisis Angka',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Output hasil
              if (_result.isNotEmpty)
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _hasResult ? Colors.blue[50] : Colors.orange[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _hasResult ? Colors.blue[200]! : Colors.orange[200]!,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                _hasResult ? Icons.check_circle : Icons.info_outline,
                                color: _hasResult ? Colors.blue[700] : Colors.orange[700],
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _hasResult ? 'Hasil Analisis' : 'Informasi',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: _hasResult ? Colors.blue[700] : Colors.orange[700],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _result,
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.4,
                              color: Colors.grey[800],
                            ),
                          ),
                          if (_hasResult) ...[
                            const SizedBox(height: 16),
                            _buildResultCard('Prima', 
                              isPrime(double.tryParse(_controller.text) ?? 0) ? 'Ya' : 'Tidak',
                              isPrime(double.tryParse(_controller.text) ?? 0) ? Colors.green : Colors.red,
                            ),
                            _buildResultCard('Desimal', 
                              isDecimal(double.tryParse(_controller.text) ?? 0) ? 'Ya' : 'Tidak',
                              isDecimal(double.tryParse(_controller.text) ?? 0) ? Colors.green : Colors.blue,
                            ),
                            _buildResultCard('Cacah', 
                              isCacah(double.tryParse(_controller.text) ?? 0) ? 'Ya' : 'Tidak',
                              isCacah(double.tryParse(_controller.text) ?? 0) ? Colors.green : Colors.red,
                            ),
                            _buildResultCard('Bulat', 
                              getBulatStatus(double.tryParse(_controller.text) ?? 0),
                              !isDecimal(double.tryParse(_controller.text) ?? 0) ? Colors.green : Colors.red,
                            ),
                            _buildResultCard('Genap/Ganjil', 
                              getEvenOdd(double.tryParse(_controller.text) ?? 0),
                              !isDecimal(double.tryParse(_controller.text) ?? 0) ? Colors.blue : Colors.grey,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Helper functions for result logic
  bool isPrime(double number) {
    if (isDecimal(number) || number <= 1) return false;
    int intNumber = number.toInt();
    for (int i = 2; i <= intNumber ~/ 2; i++) {
      if (intNumber % i == 0) return false;
    }
    return true;
  }
  
  bool isDecimal(double number) {
    return number % 1 != 0;
  }
  
  bool isCacah(double number) {
    return !isDecimal(number) && number >= 0;
  }
  
  String getBulatStatus(double number) {
    if (isDecimal(number)) return 'Tidak';
    if (number > 0) return 'Ya (Positif)';
    if (number < 0) return 'Ya (Negatif)';
    return 'Ya (Nol)';
  }
  
  String getEvenOdd(double number) {
    if (isDecimal(number)) return 'Tidak berlaku (desimal)';
    return number.toInt() % 2 == 0 ? 'Genap' : 'Ganjil';
  }
  
  // Simplified result card with less height
  Widget _buildResultCard(String label, String value, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
