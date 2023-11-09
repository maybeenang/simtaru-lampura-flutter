import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_dragmarker/flutter_map_dragmarker.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:flutter_map_line_editor/flutter_map_line_editor.dart';
import 'package:flutter_map_simtaru/data/constants/api.dart';
import 'package:flutter_map_simtaru/data/constants/colors.dart';
import 'package:flutter_map_simtaru/domain/entity/pengajuan/pengajuan.dart';
import 'package:flutter_map_simtaru/domain/entity/role/role.dart';
import 'package:flutter_map_simtaru/presentation/controllers/dio/dio_provider.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_surat_rekomendasi_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_upload_scan_surat_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/pengajuan_controller/pengajuan_verifikasi_lapangan_controller.dart';
import 'package:flutter_map_simtaru/presentation/controllers/roles/role_provider.dart';

import 'package:go_router/go_router.dart';
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
  GeoJsonParser myGeoJson = GeoJsonParser();

  // GeoJsonParser myGeoJson = GeoJsonParser();

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
  late LatLng centerLatLng;

  void getPoly() async {
    myGeoJson.defaultPolygonBorderColor = AppColors.whiteColor;
    myGeoJson.defaultPolygonBorderStroke = 2;
    myGeoJson.defaultPolygonIsFilled = true;
    // myGeoJson.defaultPolygonFillColor = AppColors.primaryColor.withOpacity(0.7);
    final fillColor = widget.pengajuan.color_polygon ?? "#ADD8E6";
    try {
      myGeoJson.defaultPolygonFillColor = Color(
        int.parse(
          fillColor.substring(1, 7),
          radix: 16,
        ),
      ).withOpacity(0.7);
    } catch (e) {
      myGeoJson.defaultPolygonFillColor = Colors.black.withOpacity(0.7);
    }
    myGeoJson.parseGeoJson(await jsonDecode(widget.pengajuan.titik_polygon!));
  }

  void getLatLng() {
    final List<String> latlng = widget.pengajuan.titik_koordinat?.split(",") ?? [];

    if (latlng.isNotEmpty) {
      try {
        centerLatLng = LatLng(
          double.parse(latlng[0]),
          double.parse(latlng[1]),
        );
      } catch (e) {
        centerLatLng = LatLng(-4.838455515616654, 104.89554453973685);
      }
    } else {
      centerLatLng = LatLng(-4.838455515616654, 104.89554453973685);
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.pengajuan.titik_polygon != "") {
      getPoly();
    }

    getLatLng();

    isEditing = false;
    polyEditor = PolyEditor(
      addClosePathMarker: true,
      points: testPolygon.points,
      pointIcon: const Icon(
        Icons.circle,
        size: 23,
        color: AppColors.whiteColor,
      ),
      intermediateIcon: const Icon(Icons.lens, size: 20, color: Colors.black),
      callbackRefresh: () => {setState(() {})},
    );

    polygons.add(testPolygon);
    valuePerizinan = widget.pengajuan.jenis_perizinan != null
        ? widget.pengajuan.jenis_perizinan == "1"
            ? list.first
            : "Non Berusaha"
        : list.first;
    valueUMKM = umkm.first;
    showUMKM = widget.pengajuan.jenis_perizinan != null
        ? widget.pengajuan.jenis_perizinan == "1"
            ? true
            : false
        : false;
  }

  @override
  Widget build(BuildContext context) {
    final roleState = ref.watch(roleProvider);

    final dio = ref.watch(dioProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Rekam Polygon ${widget.pengajuan.nama_lengkap}"),
      ),
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
          center: centerLatLng,
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
          widget.pengajuan.titik_polygon != null
              ? PolygonLayer(
                  polygons: myGeoJson.polygons,
                )
              : const SizedBox(),
          MarkerLayer(
            markers: [
              Marker(
                width: 100.0,
                height: 100.0,
                point: centerLatLng,
                builder: (ctx) => const Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          PolygonLayer(
            polygons: polygons,
          ),
          isEditing ? DragMarkers(markers: polyEditor.edit()) : const SizedBox()
        ],
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: roleState is Surveyor
          ? null
          : ExpandableFab(
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
                      handleSubmit(geojson, dio);
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

  Future handleSubmit(Map geoJson, Dio dio) async {
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
        try {
          String jenis_perizinan = valuePerizinan == "Berusaha" ? "1" : "2";
          String umkm = valueUMKM == "UMKM" ? "umkm" : "nonumkm";

          final data = jenis_perizinan == "1"
              ? {
                  "titik_polygon": jsonEncode(geoJson),
                  "jenis_perizinan": jenis_perizinan,
                  "jenis_berusaha": umkm,
                  "color_polygon": umkm == "umkm" ? "#COCOCO" : "#FFA500"
                }
              : {
                  "titik_polygon": jsonEncode(geoJson),
                  "jenis_perizinan": jenis_perizinan,
                  "jenis_berusaha": "",
                  "color_polygon": "#ADD8E6"
                };

          // final Dio dio = Dio();
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
            ref.invalidate(pengajuanVerifikasiLapanganControllerProvider);
            ref.invalidate(pengajuanUploadScanSuratControllerProvider);
            ref.invalidate(pengajuanSuratRekomendasiControllerProvider);
            Flushbar(
              message: "Berhasil merekam polygon",
              backgroundColor: AppColors.greenColor,
              duration: const Duration(seconds: 1),
              flushbarPosition: FlushbarPosition.TOP,
              flushbarStyle: FlushbarStyle.FLOATING,
              animationDuration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.all(8),
              borderRadius: BorderRadius.circular(8),
              isDismissible: true,
              shouldIconPulse: false,
              icon: const Icon(
                Icons.check,
                color: AppColors.whiteColor,
              ),
            ).show(context).then(
              (value) {
                context.pop();
              },
            );
          }
        } catch (e) {
          print("RROR DISINI $e");
          if (context.mounted) {
            context.loaderOverlay.hide();
            Flushbar(
              message: "Gagal merekam polygon",
              backgroundColor: AppColors.redColor,
              duration: const Duration(seconds: 1),
              flushbarPosition: FlushbarPosition.TOP,
              flushbarStyle: FlushbarStyle.FLOATING,
              animationDuration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.all(8),
              borderRadius: BorderRadius.circular(8),
              isDismissible: true,
              shouldIconPulse: false,
              icon: const Icon(
                Icons.check,
                color: AppColors.whiteColor,
              ),
            );
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
