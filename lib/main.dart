import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlng;

void main() {
  runApp(const FamilyTrackingApp());
}

class FamilyTrackingApp extends StatelessWidget {
  const FamilyTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Family Tracker (Free)',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final List<Marker> _markers = [];

  // Simulated locations in Florida
  final latlng.LatLng _myLocation = latlng.LatLng(28.5383, -82.3459); // Central Florida
  final latlng.LatLng _wifeLocation = latlng.LatLng(27.9944, -81.7603); // Near Orlando
  final latlng.LatLng _catLocation = latlng.LatLng(29.1872, -81.5639); // Near Daytona Beach
  final latlng.LatLng _fordLocation = latlng.LatLng(26.1421, -80.2862); // Near Fort Lauderdale

  @override
  void initState() {
    super.initState();
    _addSimulatedMarkers();
  }

  void _addSimulatedMarkers() {
    setState(() {
      _markers.addAll([
        Marker(
          point: _myLocation,
          width: 50,
          height: 50,
          child: _buildMarkerIcon(Icons.person_pin_circle, Colors.blue, 'You'),
        ),
        Marker(
          point: _wifeLocation,
          width: 50,
          height: 50,
          child: _buildMarkerIcon(Icons.favorite_border, Colors.pink, 'Wife'),
        ),
        Marker(
          point: _catLocation,
          width: 50,
          height: 50,
          child: _buildMarkerIcon(Icons.pets, Colors.green, 'Cat'),
        ),
        Marker(
          point: _fordLocation,
          width: 50,
          height: 50,
          child: _buildMarkerIcon(Icons.directions_car_filled, Colors.red, 'Car'),
        ),
      ]);
    });
  }

  Widget _buildMarkerIcon(IconData icon, Color color, String label) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.8),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(1.0, 1.0),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Tracker (Free)'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: latlng.LatLng(28.5383, -82.3459), // Central Florida
          zoom: 7.0,
          minZoom: 3.0,
          maxZoom: 18.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(markers: _markers),
        ],
      ),
    );
  }
}
