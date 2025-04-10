import 'package:flutter/material.dart';
import 'package:tugaskelompok/listsitus.dart';


class SitusRekomendasi extends StatefulWidget {
  const SitusRekomendasi({super.key});

  @override
  State<SitusRekomendasi> createState() => _SitusRekomendasiState();
}

class _SitusRekomendasiState extends State<SitusRekomendasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 226, 226),
      appBar: AppBar(
        title: Text(
          "Rekomendasi Situs",
        ),
      ),
      body: Center(
        child: Column(
          children: [
            _listViewWidget(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                  width: 450,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Kembali"))),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listViewWidget() {
    return Expanded(
        child: ListView.builder(
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: Image.asset(
              '${menuItems[index]["image"]}',
              width: 50,
              height: 50,
            ),
            title: Text('${menuItems[index]["judul"]}'),
            subtitle: Text('${menuItems[index]["link"]}'),
          ),
        );
      },
    ));
  }
}
