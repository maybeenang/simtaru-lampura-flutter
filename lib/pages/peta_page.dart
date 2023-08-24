import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_simtaru/geojson/geojson/classes.dart';
import 'package:flutter_map_simtaru/geojson/geojson/geojson.dart';
import 'package:flutter_map_simtaru/geojson/geojson/geojson_options.dart';
import 'package:flutter_map_simtaru/geojson/geojson/geojson_widget.dart';
import 'package:flutter_map_simtaru/geojson/geojson/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui' as dartui;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';

final isLoading = StateProvider.autoDispose<bool>((ref) => false);

class PetaPage extends ConsumerStatefulWidget {
  const PetaPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PetaPageState createState() => _PetaPageState();
}

class _PetaPageState extends ConsumerState<PetaPage>
    with TickerProviderStateMixin {
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

  @override
  void initState() {
    super.initState();
    ref.read(isLoading);
    mapController = MapController();
    CustomImages().loadPlane();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        ref.read(isLoading.notifier).state = false;
        geoJsonIndex = await geoJSON.createIndex('assets/json/testing2.json',
            tileSize: tileSize, keepSource: true, buffer: 32);
        ref.read(isLoading.notifier).state = true;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(isLoading);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: !loading
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: mapController,
              options: MapOptions(
                onTap: (tapPosition, point) async {
                  featureSelected = null;
                  var pt = const Epsg3857()
                      .latLngToPoint(point, mapController.zoom.floorToDouble());
                  var x = (pt.x / tileSize).floor();
                  var y = (pt.y / tileSize).floor();
                  var tile =
                      geoJsonIndex.getTile(mapController.zoom.floor(), x, y);
                  print(
                      "anjy $x, $y  $point $pt  tile ${tile!.x} ${tile!.y} ${tile!.z}");

                  for (var feature in tile.features) {
                    var polygonList = feature.geometry;

                    if (feature.type != 1) {
                      if (geoJSON.isGeoPointInPoly(pt, polygonList,
                          size: tileSize)) {
                        infoText =
                            "${feature.tags['NAME']}, ${feature.tags['COUNTY']} tapped";
                        // print("$infoText");
                        // print("source IS ${feature.tags['source']}");

                        highlightedIndex = await GeoJSON().createIndex(null,
                            geoJsonMap: feature.tags['source'], tolerance: 0);

                        if (feature.tags.containsKey('NAME')) {
                          featureSelected =
                              "${feature.tags['NAME']}_${feature.tags['COUNTY']}";
                        }

                        _animatedMapMove(point, 11.5);
                      }
                    }
                  }
                  if (featureSelected != null) {
                    print("Tapped $infoText $featureSelected");
                  }

                  setState(() {});
                },
                center: LatLng(-4.838455515616654, 104.89554453973685),
                zoom: 10.0,
                maxZoom: 18.45,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://a.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                  userAgentPackageName: 'simtaru.lampura.com',
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
                          ..isAntiAlias = true;
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
                          ..isAntiAlias = true;

                        paint.color = Colors.yellow.withOpacity(0.5);

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
                          ..isAntiAlias = true;
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
                          ..isAntiAlias = true;

                        paint.color = Colors.black.withOpacity(0.5);

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
                      ..color = Colors.red.withOpacity(0.5)
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
                      ..color = Colors.purple.withOpacity(0.5)
                      ..strokeWidth = 5
                      ..isAntiAlias = true;
                  }),
                ),
              ],
            ),
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

    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
          zoomTween.evaluate(animation));
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
