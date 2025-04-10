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
    int? number = int.tryParse(input);
    if (number == null) {
      _result = 'Bukan angka valid';
    } else if (number < 0) {
      _result = 'Bulat negatif';
    } else if (number >= 0) {
      _result = 'Cacah';
    } else if (number == 1) {
      _result = 'Bukan prima';
    } else {
      bool isPrime = true;
      for (int i = 2; i <= number ~/ 2; i++) {
        if (number % i == 0) {
          isPrime = false;
          break;
        }
      }
      _result = isPrime ? 'Prima' : 'Bulat positif';
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
            ElevatedButton(onPressed: () => checkNumberType(_controller.text), child: Text('Cek')),
            SizedBox(height: 20),
            Text(_result, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}