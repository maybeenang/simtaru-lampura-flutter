import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/components/detail_pengajuan/biodata_pemohon.dart';
import 'package:flutter_map_simtaru/components/detail_pengajuan/rencana_pembangunan.dart';
import 'package:flutter_map_simtaru/components/detail_pengajuan/rincian_dokumen.dart';
import 'package:flutter_map_simtaru/components/detail_pengajuan/rincian_pengajuan.dart';

class DetailPengajuanPage extends StatelessWidget {
  const DetailPengajuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Pengajuan"),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              BiodataPemohon(),
              SizedBox(height: 10),
              RincianPengajuan(),
              SizedBox(height: 10),
              RencanaPembangunan(),
              SizedBox(height: 10),
              RincianDokumen(),
            ],
          ),
        ),
      ),
    );
  }
}
