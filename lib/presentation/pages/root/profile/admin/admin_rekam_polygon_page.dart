import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_dragmarker/flutter_map_dragmarker.dart';
import 'package:flutter_map_line_editor/flutter_map_line_editor.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
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
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: ExpandableFab(
          openButtonBuilder: RotateFloatingActionButtonBuilder(
            child: const Icon(Icons.edit),
            fabSize: ExpandableFabSize.regular,
            foregroundColor: AppColors.whiteColor,
            backgroundColor: AppColors.primaryColor,
            shape: const CircleBorder(),
          ),
          closeButtonBuilder: DefaultFloatingActionButtonBuilder(
            child: const Icon(Icons.close),
            fabSize: ExpandableFabSize.regular,
            foregroundColor: AppColors.whiteColor,
            backgroundColor: AppColors.primaryColor,
            shape: const CircleBorder(),
          ),
          distance: 60.0,
          childrenOffset: Offset(5, 5),
          type: ExpandableFabType.up,
          children: [
            FloatingActionButton.small(
              shape: const CircleBorder(),
              heroTag: null,
              backgroundColor: AppColors.redColor,
              onPressed: () {},
              child: const Icon(Icons.delete),
            ),
            FloatingActionButton.small(
              shape: const CircleBorder(),
              heroTag: null,
              backgroundColor: AppColors.actionColor,
              onPressed: () {},
              child: const Icon(Icons.undo),
            ),
            FloatingActionButton.small(
              shape: const CircleBorder(),
              heroTag: null,
              backgroundColor: AppColors.greenColor,
              onPressed: () {},
              child: const Icon(Icons.check),
            ),
          ],
        )
        // floatingActionButton: FloatingActionButton(
        //   child: const Icon(Icons.replay),
        //   onPressed: () {
        //     double getNumber(double input, {int precision = 6}) =>
        //         double.parse('$input'.substring(0, '$input'.indexOf('.') + precision + 1));
        //     Map<String, dynamic> geojson = {
        //       "type": "FeatureCollection",
        //       "features": [
        //         {
        //           "type": "Feature",
        //           "properties": {},
        //           "geometry": {
        //             "type": "Polygon",
        //             "coordinates": [
        //               // polyEditor.points.map((e) => [getNumber(e.longitude), getNumber(e.latitude)]).toList()
        //               polyEditor.points.map((e) => [e.longitude, e.latitude]).toList()
        //             ]
        //           }
        //         }
        //       ]
        //     };

        //     print(jsonEncode(geojson));
        //   },
        // ),
        );
  }
}
