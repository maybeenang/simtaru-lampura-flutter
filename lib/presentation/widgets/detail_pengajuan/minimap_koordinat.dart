import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

class MinimapKoordinat extends StatelessWidget {
  const MinimapKoordinat({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: AbsorbPointer(
        absorbing: true,
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(-4.655018, 104.738142),
            zoom: 18.0,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://a.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerLayer(markers: [
              Marker(
                  point: LatLng(-4.655018, 104.738142),
                  builder: (ctx) {
                    return const Icon(
                      Icons.location_on,
                      color: Colors.red,
                    );
                  })
            ])
          ],
        ),
      ),
    );
  }
}
