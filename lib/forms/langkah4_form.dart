import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_simtaru/components/textfield_common.dart';
import 'package:latlong2/latlong.dart';

class Langkah4Form extends StatefulWidget {
  const Langkah4Form({super.key});

  @override
  State<Langkah4Form> createState() => _Langkah4FormState();
}

class _Langkah4FormState extends State<Langkah4Form> {
  List<Marker> markers = [];
  bool isMarker = false;
  LatLng latLng = LatLng(0, 0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          width: double.infinity,
          child: Text(
            "Peta Lokasi",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          width: double.infinity,
          child: Text(
            "Pilih koordinat lokasi dengan menekan pada peta",
            style: TextStyle(
              fontSize: 16,
              color: Colors.red,
            ),
          ),
        ),
        const SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 1.0,
          child: FlutterMap(
            options: MapOptions(
              center: const LatLng(-4.838455515616654, 104.89554453973685),
              zoom: 13.0,
              onTap: (tapPosition, point) {
                setState(() {
                  markers = [];
                  markers.add(
                    Marker(
                      width: 100.0,
                      height: 100.0,
                      point: point,
                      builder: (ctx) => const Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                    ),
                  );
                  isMarker = true;
                  latLng = point;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(markers: markers.map((e) => e).toList())
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          child: Text(isMarker ? latLng.toString() : "Lokasi belum ditentukan"),
        ),
      ],
    );
  }
}
