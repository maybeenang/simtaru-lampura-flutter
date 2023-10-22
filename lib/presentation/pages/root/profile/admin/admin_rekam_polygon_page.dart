import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_dragmarker/flutter_map_dragmarker.dart';
import 'package:flutter_map_line_editor/flutter_map_line_editor.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AdminRekamPolygonPage extends StatefulHookConsumerWidget {
  const AdminRekamPolygonPage({Key? key, required this.pengajuan}) : super(key: key);

  final Pengajuan pengajuan;

  @override
  // ignore: library_private_types_in_public_api
  _AdminRekamPolygonPageState createState() => _AdminRekamPolygonPageState();
}

class _AdminRekamPolygonPageState extends ConsumerState<AdminRekamPolygonPage> {
  late PolyEditor polyEditor;
  final _key = GlobalKey<ExpandableFabState>();
  final keyPoli = GlobalKey();

  final polygons = <Polygon>[];
  var testPolygon = Polygon(
    borderColor: AppColors.whiteColor,
    borderStrokeWidth: 2,
    color: AppColors.primaryColor.withOpacity(0.7),
    isFilled: true,
    points: [],
  );

  late bool isEditing;

  final List<String> list = <String>['Berusaha', 'Non Berusaha'];
  final List<String> umkm = <String>['UMKM', 'Non UMKM'];
  late String valuePerizinan;
  late String valueUMKM;
  late bool showUMKM;
  @override
  void initState() {
    super.initState();
    isEditing = false;
    polyEditor = PolyEditor(
      addClosePathMarker: true,
      points: testPolygon.points,
      pointIcon: const Icon(
        Icons.circle,
        size: 23,
        color: AppColors.whiteColor,
      ),
      intermediateIcon: const Icon(Icons.lens, size: 15, color: Colors.grey),
      callbackRefresh: () => {setState(() {})},
    );

    polygons.add(testPolygon);
    valuePerizinan = list.first;
    valueUMKM = umkm.first;
    showUMKM = true;
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      print("KONTOOOL $showUMKM");
      return;
    }, [showUMKM]);

    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          onTap: (_, ll) {
            if (isEditing) {
              polyEditor.add(testPolygon.points, ll);
              // polygons.add(testPolygon);
            }
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
          isEditing ? DragMarkers(markers: polyEditor.edit()) : const SizedBox()
        ],
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _key,
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          child: const Icon(Icons.edit),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: AppColors.whiteColor,
          backgroundColor: AppColors.primaryColor,
          shape: const CircleBorder(),
        ),
        closeButtonBuilder: RotateFloatingActionButtonBuilder(
          child: const Icon(Icons.close),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: AppColors.whiteColor,
          backgroundColor: AppColors.primaryColor,
          shape: const CircleBorder(),
        ),
        distance: 60.0,
        childrenOffset: const Offset(5, 5),
        type: ExpandableFabType.up,
        children: [
          FloatingActionButton.small(
            shape: const CircleBorder(),
            heroTag: null,
            backgroundColor: AppColors.redColor,
            onPressed: () {
              setState(() {
                polyEditor.points.clear();
              });
            },
            child: const Icon(Icons.delete),
          ),
          FloatingActionButton.small(
            shape: const CircleBorder(),
            heroTag: null,
            backgroundColor: AppColors.mapColorStatusChip[2],
            onPressed: () {
              setState(() {
                if (polyEditor.points.isNotEmpty) {
                  final index = polyEditor.points.length - 1;
                  polyEditor.remove(index);
                }
              });
            },
            child: const Icon(Icons.undo),
          ),
          FloatingActionButton.small(
            shape: const CircleBorder(),
            heroTag: null,
            backgroundColor: AppColors.greenColor,
            onPressed: () {
              // print(widget.pengajuan.titik_polygon);
              // return;
              if (polyEditor.points.length < 3) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: "Peringatan",
                  barrierDismissible: false,
                  text: 'Silahkan pilih minimal 3 titik',
                  confirmBtnText: "OK",
                );
                return;
              }

              final state = _key.currentState;
              if (state != null) {
                debugPrint('isOpen:${state.isOpen}');
                double getNumber(double input, {int precision = 6}) =>
                    double.parse('$input'.substring(0, '$input'.indexOf('.') + precision + 1));
                Map<String, dynamic> geojson = {
                  "type": "FeatureCollection",
                  "features": [
                    {
                      "type": "Feature",
                      "properties": {},
                      "geometry": {
                        "type": "Polygon",
                        "coordinates": [
                          // polyEditor.points.map((e) => [getNumber(e.longitude), getNumber(e.latitude)]).toList()
                          polyEditor.points.map((e) => [e.longitude, e.latitude]).toList()
                        ]
                      }
                    }
                  ]
                };

                state.toggle();
                handleSubmit(geojson);
              }
            },
            child: const Icon(Icons.check),
          ),
        ],
        afterOpen: () {
          setState(() {
            isEditing = true;
          });
        },
        afterClose: () {
          setState(() {
            isEditing = false;
          });

          if (polyEditor.points.length < 3) {
            return;
          }
        },
      ),
    );
  }

  Future handleSubmit(Map geoJson) async {
    print(geoJson);

    QuickAlert.show(
      context: context,
      type: QuickAlertType.custom,
      barrierDismissible: true,
      title: "Peringatan",
      text: 'Silahkan pilih jenis perizinan',
      widget: StatefulBuilder(builder: (context, setState) {
        return Column(
          children: [
            DropdownButtonFormField<String>(
              value: valuePerizinan,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              onChanged: (String? value) {
                setState(() {
                  valuePerizinan = value!;
                  if (valuePerizinan == list.first) {
                    showUMKM = true;
                  } else {
                    showUMKM = false;
                  }
                });
              },
              onSaved: (newValue) {
                setState(() {
                  valuePerizinan = newValue!;
                });
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            showUMKM
                ? DropdownButtonFormField<String>(
                    value: valueUMKM,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    onChanged: (String? value) {
                      setState(() {
                        valueUMKM = value!;
                      });
                    },
                    onSaved: (newValue) {
                      setState(() {
                        valueUMKM = newValue!;
                      });
                    },
                    items: umkm.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                : const SizedBox()
          ],
        );
      }),
      headerBackgroundColor: AppColors.redColor,
      showConfirmBtn: true,
      showCancelBtn: true,
      confirmBtnText: 'Ya',
      cancelBtnText: 'Batal',
      confirmBtnColor: AppColors.greenColor,
      onConfirmBtnTap: () async {
        Navigator.pop(context);
        context.loaderOverlay.show();
        print("KONTOOOLLLlLLlLlLl ${jsonEncode(geoJson)}");
        // return;
        try {
          String jenis_perizinan = valuePerizinan == "Berusaha" ? "1" : "2";
          String umkm = valueUMKM == "UMKM" ? "umkm" : "nonumkm";
          // String color = jenis_perizinan

          // final formData = jenis_perizinan == "1"
          //     ? FormData.fromMap(
          //         {"titik_polygon": jsonEncode(geoJson), "jenis_berusaha": jenis_perizinan, "jenis_perizinan": umkm})
          //     : FormData.fromMap({"titik_polygon": jsonEncode(geoJson), "jenis_perizinan": jenis_perizinan});

          // final formData = FormData.fromMap({"titik_polygon": jsonEncode(geoJson).toString()});

          // print(formData.fields);

          final data = {"titik_polygon": jsonEncode(geoJson)};

          final Dio dio = Dio();
          final url = "${Endpoints.baseURL}${Endpoints.updatePolygonPengajuan}${widget.pengajuan.id}";

          print(url);
          // dio.options.headers["Authorization"] = "Bearer ${widget.pengajuan.token}";

          final Response res = await dio.put(
            url,
            data: data,
          );

          if (context.mounted) {
            print(res.data);
            context.loaderOverlay.hide();
          }
        } catch (e) {
          print("KONTOLLLLL $e");
          if (context.mounted) {
            context.loaderOverlay.hide();
          }
        } finally {
          if (context.mounted) {
            context.loaderOverlay.hide();
          }
        }
      },
    );
  }
}
