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

  Future<void> launchURL(String url) async {
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Header dengan kembali dan judul
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.blue[700]),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Situs Rekomendasi',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                  // Spacer(),
                  // _buildFavoriteButton(),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Kumpulan situs berguna untuk referensi',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: _buildFavoriteButton(),
              ),
              SizedBox(height: 20),

              // List situs
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey[50],
                  ),
                  child: _listViewWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DaftarSitusFavorite()),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.amber[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.amber[400]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: Colors.amber[800], size: 18),
            SizedBox(width: 4),
            Text(
              'Situs Favorit',
              style: TextStyle(
                color: Colors.amber[900],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listViewWidget() {
    return ListView.builder(
      padding: EdgeInsets.all(12),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        final item = menuItems[index];
        final isFav = favoriteTitles.contains(item["judul"]);

        return Container(
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => launchURL(item["link"]!),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        '${item["image"]}',
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 16),

                    // Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${item["judul"]}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '${item["link"]}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 12),

                          // Favorite button
                          GestureDetector(
                            onTap: () => _toggleFavorite(item["judul"]!),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color:
                                    isFav ? Colors.pink[50] : Colors.grey[100],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isFav
                                      ? Colors.pink[300]!
                                      : Colors.grey[300]!,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isFav
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFav
                                        ? Colors.pink[400]
                                        : Colors.grey[500],
                                    size: 16,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    isFav ? 'Favorit' : 'Tambah Favorit',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: isFav
                                          ? Colors.pink[700]
                                          : Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
