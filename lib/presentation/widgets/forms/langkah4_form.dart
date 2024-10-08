import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_simtaru/presentation/pages/root/pengajuan/pengajuan_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

class Langkah4Form extends ConsumerStatefulWidget {
  const Langkah4Form({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Langkah4FormState createState() => _Langkah4FormState();
}

class _Langkah4FormState extends ConsumerState<Langkah4Form> with TickerProviderStateMixin {
  List<Marker> markers = [];
  bool isMarker = false;
  LatLng latLng = const LatLng(0, 0);
  MapController mapController = MapController();

  bool mapType = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        Row(
          children: [
            const Text("Flat Map"),
            Switch(
              value: mapType,
              onChanged: (value) {
                setState(() {
                  mapType = value;
                });
              },
            ),
            const Text("Satellite Map"),
          ],
        ),
        AspectRatio(
          aspectRatio: 1.0,
          child: FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: const LatLng(-4.838455515616654, 104.89554453973685),
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

                  ref.read(currLatLng.notifier).state = point;
                  latLng = point;
                  _animatedMapMove(point, 18.0);
                });
              },
              zoom: 15.0,
              maxZoom: 22,
            ),
            children: [
              TileLayer(
                urlTemplate: mapType
                    ? "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}"
                    : "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'simtaru.lampura.com',
                maxNativeZoom: 18,
                maxZoom: 22,
                fallbackUrl: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),
              // TileLayer(
              //   urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              //   subdomains: const ['a', 'b', 'c'],
              //   userAgentPackageName: 'simtaru.lampura.com',
              //   maxNativeZoom: 18,
              //   maxZoom: 22,
              //   fallbackUrl: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              // ),
              MarkerLayer(markers: markers.map((e) => e).toList())
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          child: Text(isMarker ? "${latLng.latitude}, ${latLng.longitude}" : "Lokasi belum ditentukan"),
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
