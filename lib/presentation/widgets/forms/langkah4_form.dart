import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

class Langkah4Form extends StatefulWidget {
  const Langkah4Form({super.key});

  @override
  State<Langkah4Form> createState() => _Langkah4FormState();
}

class _Langkah4FormState extends State<Langkah4Form> with TickerProviderStateMixin {
  List<Marker> markers = [];
  bool isMarker = false;
  LatLng latLng = LatLng(0, 0);
  MapController mapController = MapController();

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
        if (!isMarker)
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
            mapController: mapController,
            options: MapOptions(
              center: LatLng(-4.838455515616654, 104.89554453973685),
              zoom: 13.0,
              maxZoom: 18.0,
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
                  _animatedMapMove(point, 18.0);
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: "https://a.tile.openstreetmap.org/{z}/{x}/{y}.png",
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

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final latTween = Tween<double>(
      begin: mapController.center.latitude,
      end: destLocation.latitude,
    );

    final lngTween = Tween<double>(
      begin: mapController.center.longitude,
      end: destLocation.longitude,
    );

    final zoomTween = Tween<double>(
      begin: mapController.zoom,
      end: destZoom,
    );

    final rotationTween = Tween<double>(
      begin: mapController.rotation,
      end: 0.0,
    );

    final controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    final Animation<double> animation = CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)), zoomTween.evaluate(animation));
      mapController.rotate(rotationTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }
}
