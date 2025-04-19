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
      setState(() {
        _result = 'Hasil analisis untuk angka: $number';
        _hasResult = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.blue[700]),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Jenis Bilangan',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Identifikasi angka dengan tepat',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(height: 30),
              
              // Input container
              Center(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _controller,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Masukkan angka...',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 20,
                          ),
                          filled: true,
                          fillColor: Colors.blue[50],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 16),
                          prefixIcon: Icon(
                            Icons.numbers,
                            color: Colors.blue[700],
                            size: 28,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: Colors.grey[600],
                              size: 24,
                            ),
                            onPressed: () {
                              _controller.clear();
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildControlButton(
                            icon: Icons.refresh,
                            label: "Reset",
                            color: Colors.grey[700]!,
                            onPressed: () {
                              _controller.clear();
                              setState(() {
                                _result = '';
                                _hasResult = false;
                              });
                            },
                          ),
                          _buildControlButton(
                            icon: Icons.calculate,
                            label: "Analisis",
                            color: Colors.blue[700]!,
                            onPressed: () => checkNumberType(_controller.text),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 30),
              
              // Output hasil
              if (_result.isNotEmpty)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: _hasResult 
                      ? ListView(
                          padding: EdgeInsets.all(16),
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.blue[700],
                                    size: 24,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    _result,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _buildResultCard(
                              'Prima', 
                              isPrime(double.tryParse(_controller.text) ?? 0) ? 'Ya' : 'Tidak',
                              isPrime(double.tryParse(_controller.text) ?? 0) ? Colors.green : Colors.red,
                            ),
                            _buildResultCard(
                              'Desimal', 
                              isDecimal(double.tryParse(_controller.text) ?? 0) ? 'Ya' : 'Tidak',
                              isDecimal(double.tryParse(_controller.text) ?? 0) ? Colors.green : Colors.red,
                            ),
                            _buildResultCard(
                              'Cacah', 
                              isCacah(double.tryParse(_controller.text) ?? 0) ? 'Ya' : 'Tidak',
                              isCacah(double.tryParse(_controller.text) ?? 0) ? Colors.green : Colors.red,
                            ),
                            _buildResultCard(
                              'Bulat', 
                              getBulatStatus(double.tryParse(_controller.text) ?? 0),
                              !isDecimal(double.tryParse(_controller.text) ?? 0) ? Colors.green : Colors.red,
                            ),
                            _buildResultCard(
                              'Genap/Ganjil', 
                              getEvenOdd(double.tryParse(_controller.text) ?? 0),
                              !isDecimal(double.tryParse(_controller.text) ?? 0) ? Colors.blue[700]! : Colors.grey[600]!,
                            ),
                          ],
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              _result,
                              style: TextStyle(
                                color: Colors.orange[700],
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
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
  
  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            shape: CircleBorder(),
            child: InkWell(
              customBorder: CircleBorder(),
              onTap: onPressed,
              child: Center(
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
  
  Widget _buildResultCard(String label, String value, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.blue[700],
              fontSize: 16,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
