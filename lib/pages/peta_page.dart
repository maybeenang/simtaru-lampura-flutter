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
  late GeoJSONVT? highlightedIndex =
      GeoJSONVT({}, GeoJSONVTOptions(buffer: 32));
  var infoText = 'No Info';
  var tileSize = 256.0;
  var tilePointCheckZoom = 14;

  GeoJSON geoJSON = GeoJSON();
  VectorTileIndex vectorTileIndex = VectorTileIndex();

  @override
  void initState() {
    //vectorTileIndex = GeoJSONVT({},GeoJSONVTOptions());
    super.initState();
    mapController = MapController();
    CustomImages().loadPlane();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //var geoPointMap = TestData().getSamplePointGeoJSON(100);
      //geoJsonIndex = await geoJSON.createIndex(null, tileSize: tileSize, geoJsonMap: geoPointMap);
      //geoJsonIndex = await geoJSON.createIndex('assets/test.json', tileSize: 256);
      geoJsonIndex = await geoJSON.createIndex('assets/json/data.json',
          tileSize: tileSize, keepSource: true, buffer: 32);
      //geoJsonIndex = await geoJSON.createIndex('assets/us_test.json', tileSize: tileSize);
      //geoJsonIndex = await geoJSON.createIndex('assets/ids.json', tileSize: tileSize);
      //geoJsonIndex = await geoJSON.createIndex('assets/polygon_hole.json', tileSize: 256);
      //geoJsonIndex = await geoJSON.createIndex('assets/general.json', tileSize: 256);
      //geoJsonIndex = await geoJSON.createIndex('assets/uk.json', tileSize: 256);
      //geoJsonIndex = await geoJSON.createIndex('assets/earthquake.geojson', tileSize: 256);
      setState(() {});
    });
  }

  String? featureSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(-4.838455515616654, 104.89554453973685),
          zoom: 13.0,
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
            options: GeoJSONOptions(
              featuresHaveSameStyle: false,
              overallStyleFunc: (TileFeature feature) {
                var paint = Paint()
                  ..style = PaintingStyle.stroke
                  ..color = Colors.blue
                  ..strokeWidth = 5
                  ..isAntiAlias = false;
                if (feature.type == 3) {
                  // lineString
                  paint.style = PaintingStyle.fill;
                }
                return paint;
              },
              pointWidgetFunc: (TileFeature feature) {
                //return const Text("Point!", style: TextStyle(fontSize: 10));
                return const Icon(Icons.airplanemode_on);
              },
              pointStyle: (TileFeature feature) {
                return Paint();
              },
              pointFunc: (TileFeature feature, Canvas canvas) {
                if (CustomImages.imageLoaded) {
                  canvas.drawImage(
                      CustomImages.plane, const Offset(0.0, 0.0), Paint());
                }
              },

              ///clusterFunc: () { return Text("Cluster"); },
              ///lineStringFunc: () { if(CustomImages.imageLoaded) return CustomImages.plane;}
              lineStringStyle: (feature) {
                return Paint()
                  ..style = PaintingStyle.stroke
                  ..color = Colors.red
                  ..strokeWidth = 2
                  ..isAntiAlias = true;
              },
            ),
          ),
          GeoJSONWidget(
            index: highlightedIndex,
            drawFeatures: true,
            options: GeoJSONOptions(polygonStyle: (feature) {
              return Paint()
                ..style = PaintingStyle.stroke
                ..color = Colors.yellow
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
