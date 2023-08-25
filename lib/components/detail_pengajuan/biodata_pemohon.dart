import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';

class BiodataPemohon extends StatelessWidget {
  const BiodataPemohon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Biodata Pemohon",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(),
          Text(
            "Nama",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "John Doe",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "No Identitas",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "1871025108990006",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Alamat",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "Jl.Griya Kencana Blok K No.5 LK.II RT/RW 003/000, Kelurahan Wayhalim Permai, Kecamatan Way Halim, Kota Bandar Lampung",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Tempat Tanggal Lahir",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "Bandar Lampung, 11-08-1999",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Pekerjaan",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "Pelajar/ Mahasiswa",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "No HP",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "081234567890",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
