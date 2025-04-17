import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class TrackingLBSPage extends StatefulWidget {
  const TrackingLBSPage({super.key});

  @override
  _TrackingLBSPageState createState() => _TrackingLBSPageState();
}

class _TrackingLBSPageState extends State<TrackingLBSPage> {
  String _locationMessage = "Lokasi belum didapatkan";
  double? _latitude;
  double? _longitude;

  final String _tomtomApiKey = 'tFrmWF0If1lscn3lGvAAoGAVUrIB2450'; // Ganti dengan API key kamu

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Cek apakah layanan lokasi aktif
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => _locationMessage = "Layanan lokasi tidak aktif.");
      return;
    }

    // Cek permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _locationMessage = "Izin lokasi ditolak.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => _locationMessage = "Izin lokasi ditolak permanen.");
      return;
    }

    // Ambil lokasi
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _latitude = position.latitude;
      _longitude = position.longitude;
      _locationMessage =
          'Latitude: ${position.latitude.toStringAsFixed(8)}, Longitude: ${position.longitude.toStringAsFixed(8)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tracking Lokasi")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, size: 80, color: Colors.blue),
              SizedBox(height: 20),
              Text(
                _locationMessage,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _getCurrentLocation,
                icon: Icon(Icons.my_location),
                label: Text("Dapatkan Lokasi"),
              ),
              SizedBox(height: 30),
              // Tampilkan peta jika lokasi sudah tersedia
              if (_latitude != null && _longitude != null)
                Container(
                  height: 300,
                  width: double.infinity,
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(_latitude!, _longitude!),
                      zoom: 15.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://api.tomtom.com/map/1/tile/basic/main/{z}/{x}/{y}.png?key=$_tomtomApiKey",
                        userAgentPackageName: 'com.example.app',
                      ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              width: 60.0,
                              height: 60.0,
                              point: LatLng(_latitude!, _longitude!),
                              child: Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
