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

  Future<void> launchURL(String url) async {
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
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber[700], size: 28),
                      SizedBox(width: 8),
                      Text(
                        'Situs Favorit',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Koleksi situs yang Anda tandai sebagai favorit',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(height: 24),
              
              // Daftar favorit
              Expanded(
                child: favoriteItems.isEmpty
                    ? _buildEmptyState()
                    : _buildFavoritesList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.star_border,
            size: 80,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            "Belum ada situs favorit",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Tandai situs sebagai favorit untuk melihatnya di sini",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back),
            label: Text("Kembali ke Rekomendasi"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[50],
      ),
      child: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          final item = favoriteItems[index];
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
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${item["judul"]}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[800],
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.favorite,
                                  color: Colors.pink[400],
                                  size: 20,
                                ),
                              ],
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
                            
                            // Visit button
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.blue[200]!),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.open_in_new,
                                    color: Colors.blue[700],
                                    size: 16,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'Kunjungi Situs',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blue[700],
                                    ),
                                  ),
                                ],
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
      ),
    );
  }
}
