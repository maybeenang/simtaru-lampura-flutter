import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_dragmarker/flutter_map_dragmarker.dart';
import 'package:flutter_map_line_editor/flutter_map_line_editor.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

class AdminRekamPolygonPage extends StatefulWidget {
  const AdminRekamPolygonPage({Key? key, required this.pengajuan}) : super(key: key);

  final Pengajuan pengajuan;

  @override
  State<AdminRekamPolygonPage> createState() => _PolygonPageState();
}

class _PolygonPageState extends State<AdminRekamPolygonPage> {
  late PolyEditor polyEditor;

  final polygons = <Polygon>[];
  final testPolygon = Polygon(
    color: AppColors.actionColor.withOpacity(0.5),
    isFilled: true,
    points: [],
  );

  @override
  void initState() {
    super.initState();

    polyEditor = PolyEditor(
      addClosePathMarker: true,
      points: testPolygon.points,
      pointIcon: const Icon(Icons.crop_square, size: 23),
      intermediateIcon: const Icon(Icons.lens, size: 15, color: Colors.grey),
      callbackRefresh: () => {setState(() {})},
    );

    polygons.add(testPolygon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rekam Polygon ${widget.pengajuan.nama_lengkap}')),
      body: FlutterMap(
        options: MapOptions(
          onTap: (_, ll) {
            polyEditor.add(testPolygon.points, ll);
          },
          // For backwards compatibility with pre v5 don't use const
          // ignore: prefer_const_constructors
          center: LatLng(-4.838455515616654, 104.89554453973685),
          zoom: 15.0,
          maxZoom: 22,
        ),
        children: [
          TileLayer(
            urlTemplate:
                "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}",
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: 'simtaru.lampura.com',
            maxNativeZoom: 18,
            maxZoom: 22,
            fallbackUrl: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          ),
          PolygonLayer(polygons: polygons),
          DragMarkers(markers: polyEditor.edit()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.replay),
        onPressed: () {
          // convert to geojson
        },
      ),
    );
  }
}
