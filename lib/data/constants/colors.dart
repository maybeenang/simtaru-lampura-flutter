import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF1E68ED);
  static const Color secondaryColor = Color(0xFF11489C);
  static const Color bgColor = Color(0xFFf7f7f9);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color greyColor = Color(0xFF8C8C8C);
  static const Color borderColor = Color(0xFFDCDCDC);
  static const Color actionColor = Color(0xFFF94C10);
  static const Color redColor = Color(0xFFE72012);
  static const Color greenColor = Color(0xFF24B300);
  static const Color pengajuanSelesai = Colors.green;
  static Color pengajuandiProses = Colors.amber.shade700;
  static const Color pengajuandiTolak = Color(0xFFe44d5c);
  static final mapColorStatusChip = {
    1: AppColors.pengajuandiTolak,
    2: AppColors.pengajuandiProses,
    3: AppColors.pengajuandiProses,
    4: AppColors.pengajuandiProses,
    5: AppColors.pengajuandiProses,
    6: AppColors.pengajuandiProses,
    7: AppColors.pengajuandiProses,
    8: AppColors.pengajuandiProses,
    9: AppColors.pengajuandiProses,
    10: AppColors.pengajuandiProses,
    11: AppColors.pengajuandiProses,
    12: AppColors.pengajuanSelesai,
  };
}
