import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugaskelompok/listsitus.dart';
import 'package:url_launcher/url_launcher.dart';

class DaftarSitusFavorite extends StatefulWidget {
  const DaftarSitusFavorite({super.key});

  @override
  State<DaftarSitusFavorite> createState() => _DaftarSitusFavoriteState();
}

class _DaftarSitusFavoriteState extends State<DaftarSitusFavorite> {
  List<Map<String, String>> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteItems();
  }

  Future<void> LaunchURL(String url) async {
    launchUrl(Uri.parse(url));
  }

  Future<void> _loadFavoriteItems() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteTitles = prefs.getStringList('favorites') ?? [];

    // Cocokkan dengan data di menuItems
    final filtered = menuItems
        .where((item) => favoriteTitles.contains(item['judul']))
        .toList();

    setState(() {
      favoriteItems = filtered.cast<Map<String, String>>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Situs Favorit")),
      body: favoriteItems.isEmpty
          ? Center(child: Text("Belum ada situs favorit."))
          : ListView.builder(
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                final item = favoriteItems[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  elevation: 3,
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
                  ),
                );
              },
            ),
    );
  }
}
