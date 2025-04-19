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
  bool _isLoading = false;

  final String _tomtomApiKey = 'tFrmWF0If1lscn3lGvAAoGAVUrIB2450'; // Ganti dengan API key kamu

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });
    
    bool serviceEnabled;
    LocationPermission permission;

    // Cek apakah layanan lokasi aktif
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = "Layanan lokasi tidak aktif.";
        _isLoading = false;
      });
      return;
    }

    // Cek permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = "Izin lokasi ditolak.";
          _isLoading = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage = "Izin lokasi ditolak permanen.";
        _isLoading = false;
      });
      return;
    }

    // Ambil lokasi
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
        _locationMessage =
            'Latitude: ${position.latitude.toStringAsFixed(8)}\nLongitude: ${position.longitude.toStringAsFixed(8)}';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _locationMessage = "Gagal mendapatkan lokasi: $e";
        _isLoading = false;
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
              // Header yang sama dengan stopwatch & NumberTypePage
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.blue[700]),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Tracking Lokasi',
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
                  'Dapatkan lokasi dengan tepat',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(height: 30),
              
              // Location container
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
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 60,
                              color: Colors.blue[700],
                            ),
                            SizedBox(height: 16),
                            _isLoading
                              ? CircularProgressIndicator(color: Colors.blue[700])
                              : Text(
                                  _locationMessage,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[800],
                                    height: 1.5,
                                  ),
                                ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildControlButton(
                            icon: Icons.my_location,
                            label: "Dapatkan Lokasi",
                            color: Colors.blue[700]!,
                            onPressed: _isLoading ? null : _getCurrentLocation,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 30),
              
              // Map Container
              if (_latitude != null && _longitude != null)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[200]!),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
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
                  ),
                ),
              
              // Placeholder message when map isn't available
              if (_latitude == null || _longitude == null)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.map_outlined,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Dapatkan lokasi untuk menampilkan peta",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
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

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback? onPressed,
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
                  color: onPressed == null ? Colors.grey[400] : color,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: onPressed == null ? Colors.grey[400] : color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
