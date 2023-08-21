import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_simtaru/geojson/geojson/classes.dart';
import 'package:flutter_map_simtaru/geojson/geojson/geojson.dart';
import 'package:flutter_map_simtaru/geojson/geojson/geojson_options.dart';
import 'package:flutter_map_simtaru/geojson/geojson/geojson_widget.dart';
import 'package:flutter_map_simtaru/geojson/geojson/index.dart';
import 'package:flutter_map_simtaru/geojson/vector_tile/vector_tile.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui' as dartui;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:typed_data';

class PetaPage extends StatefulWidget {
  const PetaPage({super.key});

  @override
  State<PetaPage> createState() => _PetaPageState();
}

class _PetaPageState extends State<PetaPage> {
  final _random = Random();
  double doubleInRange(num start, num end) =>
      _random.nextDouble() * (end - start) + start;

  late final MapController mapController;
  late GeoJSONVT geoJsonIndex = GeoJSONVT({}, GeoJSONVTOptions(buffer: 32));
  GeoJSONVT? highlightedIndex = GeoJSONVT({}, GeoJSONVTOptions(buffer: 32));
  var infoText = 'No Info';
  var tileSize = 256;
  var tilePointCheckZoom = 14;
  String? featureSelected;

  GeoJSON geoJSON = GeoJSON();
  // VectorTileIndex vectorTileIndex = VectorTileIndex();

  @override
  void initState() {
    //vectorTileIndex = GeoJSONVT({},GeoJSONVTOptions());
    super.initState();
    mapController = MapController();
    CustomImages().loadPlane();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      geoJsonIndex = await geoJSON.createIndex('assets/json/testing2.json',
          tileSize: tileSize, keepSource: true, buffer: 32);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          onTap: (tapPosition, point) async {
            featureSelected = null;
            var pt = const Epsg3857()
                .latLngToPoint(point, mapController.zoom.floorToDouble());
            var x = (pt.x / tileSize).floor();
            var y = (pt.y / tileSize).floor();
            var tile = geoJsonIndex.getTile(mapController.zoom.floor(), x, y);
            print("$x, $y  $point $pt  tile ${tile!.x} ${tile!.y} ${tile!.z}");

            if (tile != null) {
              for (var feature in tile.features) {
                var polygonList = feature.geometry;

                if (feature.type != 1) {
                  if (geoJSON.isGeoPointInPoly(pt, polygonList,
                      size: tileSize)) {
                    infoText =
                        "${feature.tags['NAME']}, ${feature.tags['COUNTY']} tapped";
                    print("$infoText");
                    print("source IS ${feature.tags['source']}");

                    highlightedIndex = await GeoJSON().createIndex(null,
                        geoJsonMap: feature.tags['source'], tolerance: 0);

                    if (feature.tags.containsKey('NAME')) {
                      featureSelected =
                          "${feature.tags['NAME']}_${feature.tags['COUNTY']}";
                    }
                  }
                }
              }
              if (featureSelected != null) {
                print("Tapped $infoText $featureSelected");
              }
            }
            setState(() {});
          },
          center: LatLng(-4.838455515616654, 104.89554453973685),
          zoom: 10.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          GeoJSONWidget(
            drawClusters: false,
            drawFeatures: true,
            index: geoJsonIndex,
            noSlice: false,
            options: GeoJSONOptions(
                featuresHaveSameStyle: false,
                overallStyleFunc: (TileFeature feature) {
                  var paint = Paint()
                    ..style = PaintingStyle.fill
                    ..color = Colors.blue
                    ..strokeWidth = 5
                    ..isAntiAlias = false;
                  if (feature.type == 3) {
                    // lineString
                    paint.style = PaintingStyle.fill;
                  }
                  return paint;
                },
                polygonStyle: (feature) {
                  var paint = Paint()
                    ..style = PaintingStyle.fill
                    ..color = Colors.red
                    ..strokeWidth = 3
                    ..isAntiAlias = false;

                  paint.color = Colors.yellow;

                  paint.isAntiAlias = false;

                  return paint;
                }),
          ),
          GeoJSONWidget(
            drawClusters: false,
            drawFeatures: true,
            index: geoJsonIndex,
            noSlice: false,
            options: GeoJSONOptions(
                featuresHaveSameStyle: false,
                overallStyleFunc: (TileFeature feature) {
                  var paint = Paint()
                    ..style = PaintingStyle.fill
                    ..color = Colors.blue
                    ..strokeWidth = 5
                    ..isAntiAlias = false;
                  if (feature.type == 3) {
                    // lineString
                    paint.style = PaintingStyle.fill;
                  }
                  return paint;
                },
                polygonStyle: (feature) {
                  var paint = Paint()
                    ..style = PaintingStyle.stroke
                    ..color = Colors.red
                    ..strokeWidth = 3
                    ..isAntiAlias = false;

                  paint.color = Colors.black;

                  paint.isAntiAlias = false;

                  return paint;
                }),
          ),
          GeoJSONWidget(
            index: highlightedIndex,
            drawFeatures: true,
            options: GeoJSONOptions(polygonStyle: (feature) {
              return Paint()
                ..style = PaintingStyle.fill
                ..color = Colors.red
                ..strokeWidth = 8
                ..isAntiAlias = true;
            }),
          ),
          GeoJSONWidget(
            index: highlightedIndex,
            drawFeatures: true,
            options: GeoJSONOptions(polygonStyle: (feature) {
              return Paint()
                ..style = PaintingStyle.stroke
                ..color = Colors.purple
                ..strokeWidth = 5
                ..isAntiAlias = true;
            }),
          ),
        ],
      ),
    );
  }
}

class CustomImages {
  static late dartui.Image plane;
  static late bool imageLoaded = false;

  void loadPlane() async {
    plane = await loadUiImage('assets/aeroplane.png');
    imageLoaded = true;
  }

  Future<dartui.Image> loadUiImage(String imageAssetPath) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final Completer<dartui.Image> completer = Completer();
    dartui.decodeImageFromList(Uint8List.view(data.buffer), (dartui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }
}
