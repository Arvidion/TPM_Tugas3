import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugaskelompok/listsitus.dart';
import 'package:tugaskelompok/situsfavorite.dart';
import 'package:url_launcher/url_launcher.dart';

class SitusRekomendasi extends StatefulWidget {
  const SitusRekomendasi({super.key});

  @override
  State<SitusRekomendasi> createState() => _SitusRekomendasiState();
}

class _SitusRekomendasiState extends State<SitusRekomendasi> {
  Set<String> favoriteTitles = {};

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteTitles = prefs.getStringList('favorites')?.toSet() ?? {};
    });
  }

  Future<void> LaunchURL(String url) async {
    launchUrl(Uri.parse(url));
  }

  Future<void> _toggleFavorite(String title) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (favoriteTitles.contains(title)) {
        favoriteTitles.remove(title);
      } else {
        favoriteTitles.add(title);
      }
      prefs.setStringList('favorites', favoriteTitles.toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 226, 226),
      appBar: AppBar(
        title: Text("Rekomendasi Situs"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DaftarSitusFavorite()),
              );
            },
            child: Text("Lihat Favorit"),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _listViewWidget()),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              width: 450,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Kembali"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listViewWidget() {
    return ListView.builder(
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        final item = menuItems[index];
        final isFav = favoriteTitles.contains(item["judul"]);

        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            elevation: 4,
            child: ListTile(
              leading: Image.asset(
                '${item["image"]}',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              title: GestureDetector(
                onTap: () {
                  LaunchURL(item["link"]!);
                },
                child: Text(
                  '${item["judul"]}',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: Text('${item["link"]}'),
              trailing: ElevatedButton(
                onPressed: () => _toggleFavorite(item["judul"]!),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFav
                      ? const Color.fromARGB(255, 40, 126, 43)
                      : Colors.lightGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isFav
                    ? Icon(Icons.check, color: Colors.white, size: 24)
                    : Text(
                        '+ favorite',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
