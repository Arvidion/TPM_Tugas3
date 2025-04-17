import 'package:flutter/material.dart';

class NumberTypePage extends StatefulWidget {
  const NumberTypePage({super.key});

  @override
  State<NumberTypePage> createState() => _NumberTypePageState();
}

class _NumberTypePageState extends State<NumberTypePage> {
  final _controller = TextEditingController();
  String _result = '';

  void checkNumberType(String input) {
    double? number = double.tryParse(input);
    if (number == null) {
      _result = 'Bukan angka valid';
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
          bulatStatus = 'ya (positif)'; // angka 0 termasuk cacah dan bulat
        }
      }

      _result = 'prima : ${isPrime ? 'ya' : 'tidak'}\n'
          'decimal : ${isDecimal ? 'ya' : 'tidak'}\n'
          'cacah : ${isCacah ? 'ya' : 'tidak'}\n'
          'bulat : $bulatStatus';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Jenis Bilangan")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Masukkan angka'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () => checkNumberType(_controller.text),
                child: Text('Cek')),
            SizedBox(height: 20),
            Text(_result, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
