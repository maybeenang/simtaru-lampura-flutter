import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_dragmarker/flutter_map_dragmarker.dart';
import 'package:flutter_map_line_editor/flutter_map_line_editor.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
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
  }

  @override
  Widget build(BuildContext context) {
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

                handleSubmit(jsonEncode(geojson));
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
          },
        ));
  }

  Future handleSubmit(String geoJson) async {
    print(geoJson);
    AlertDialog alert = AlertDialog(
      title: Text("Login Berhasil"),
      content: //
          Column(
        children: [
          DropdownButton<String>(
            value: valuePerizinan,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? value) {
              setState(() {
                valuePerizinan = value!;
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          valuePerizinan == "UMKM"
              ? DropdownButton<String>(
                  value: valueUMKM,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      valueUMKM = value!;
                    });
                  },
                  items: umkm.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              : SizedBox()
        ],
      ),
      actions: [
        TextButton(
          child: Text('Ok'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );

    showDialog(context: context, builder: (context) => alert);

    // QuickAlert.show(
    //   context: context,
    //   type: QuickAlertType.custom,
    //   barrierDismissible: true,
    //   title: "Peringatan",
    //   text: 'Silahkan pilih jenis perizinan',
    //   widget: Column(
    //     children: [
    //       DropdownButton<String>(
    //         value: valuePerizinan,
    //         icon: const Icon(Icons.arrow_downward),
    //         elevation: 16,
    //         style: const TextStyle(color: Colors.deepPurple),
    //         underline: Container(
    //           height: 2,
    //           color: Colors.deepPurpleAccent,
    //         ),
    //         onChanged: (String? value) {
    //           setState(() {
    //             valuePerizinan = value!;
    //           });
    //         },
    //         items: list.map<DropdownMenuItem<String>>((String value) {
    //           return DropdownMenuItem<String>(
    //             value: value,
    //             child: Text(value),
    //           );
    //         }).toList(),
    //       ),
    //       valuePerizinan == "UMKM"
    //           ? DropdownButton<String>(
    //               value: valueUMKM,
    //               icon: const Icon(Icons.arrow_downward),
    //               elevation: 16,
    //               style: const TextStyle(color: Colors.deepPurple),
    //               underline: Container(
    //                 height: 2,
    //                 color: Colors.deepPurpleAccent,
    //               ),
    //               onChanged: (String? value) {
    //                 setState(() {
    //                   valueUMKM = value!;
    //                 });
    //               },
    //               items: umkm.map<DropdownMenuItem<String>>((String value) {
    //                 return DropdownMenuItem<String>(
    //                   value: value,
    //                   child: Text(value),
    //                 );
    //               }).toList(),
    //             )
    //           : SizedBox()
    //     ],
    //   ),
    //   headerBackgroundColor: AppColors.redColor,
    //   showConfirmBtn: true,
    //   showCancelBtn: true,
    //   confirmBtnText: 'Ya',
    //   cancelBtnText: 'Batal',
    //   confirmBtnColor: AppColors.redColor,
    // );
  }
}
