import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/hotspot_location.dart';

class HotspotMap extends StatelessWidget {
  const HotspotMap({super.key});

  static final List<HotspotLocation> hotspots = [
    HotspotLocation(name: 'Bungoma CBD', lat: 0.5633, lng: 34.5606),
    HotspotLocation(name: 'Township', lat: 0.5660, lng: 34.5581),
    HotspotLocation(name: 'Mayanja Area', lat: 0.5598, lng: 34.5662),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(0.5633, 34.5606),
          initialZoom: 14,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.bazutel.website',
          ),
          MarkerLayer(
            markers: hotspots.map((spot) {
              return Marker(
                width: 40,
                height: 40,
                point: LatLng(spot.lat, spot.lng),
                child: Tooltip(
                  message: spot.name,
                  child: const Icon(Icons.wifi, color: Colors.blue, size: 32),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
