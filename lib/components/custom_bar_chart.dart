import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/bar_graph/bar_data.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';
import 'package:flutter_map_simtaru/constants/double.dart';
import 'package:flutter_map_simtaru/styles/styles.dart';

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    BarData data = BarData(
      jan: 68,
      feb: 30,
      mar: 36,
      apr: 10,
      mei: 30,
      jun: 12,
      jul: 20,
      agu: 98,
      sep: 58,
      okt: 23,
      nov: 76,
      des: 67,
    );
    data.initializeBarData();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDouble.borderRadius),
          boxShadow: [
            AppStyles.boxShadowStyle,
          ],
        ),
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
              child: Text(
                "Grafik Pengajuan Perbulan",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
            AspectRatio(
              aspectRatio: 2,
              child: BarChart(
                BarChartData(
                  maxY: data.barData.map((data) => data.y).toList().reduce(
                      (value, element) => value > element ? value : element),
                  minY: 0,
                  borderData: FlBorderData(
                      show: true,
                      border: const Border(
                        left: BorderSide.none,
                        bottom: BorderSide.none,
                        right: BorderSide.none,
                        top: BorderSide.none,
                      )),
                  gridData:
                      const FlGridData(show: true, drawVerticalLine: false),
                  alignment: BarChartAlignment.spaceAround,
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: true, getTitlesWidget: getBottomTitles),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 25,
                        getTitlesWidget: getLeftTitles,
                      ),
                    ),
                  ),
                  barGroups: data.barData
                      .map(
                        (data) => BarChartGroupData(
                          x: data.x,
                          barRods: [
                            BarChartRodData(
                              toY: data.y,
                              color: AppColors.secondaryColor,
                              width: 10,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getLeftTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: AxisSide.left,
      child: Text(
        value.toInt().toString(),
        textAlign: TextAlign.left,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 12,
    );

    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text(
          'Jan',
          style: textStyle,
        );
        break;
      case 2:
        text = const Text(
          'Feb',
          style: textStyle,
        );
        break;
      case 3:
        text = const Text(
          'Mar',
          style: textStyle,
        );
        break;
      case 4:
        text = const Text(
          'Apr',
          style: textStyle,
        );
        break;
      case 5:
        text = const Text(
          'Mei',
          style: textStyle,
        );
        break;
      case 6:
        text = const Text(
          'Jun',
          style: textStyle,
        );
        break;
      case 7:
        text = const Text(
          'Jul',
          style: textStyle,
        );
        break;
      case 8:
        text = const Text(
          'Agu',
          style: textStyle,
        );
        break;
      case 9:
        text = const Text(
          'Sep',
          style: textStyle,
        );
        break;
      case 10:
        text = const Text(
          'Okt',
          style: textStyle,
        );
        break;
      case 11:
        text = const Text(
          'Nov',
          style: textStyle,
        );
        break;
      case 12:
        text = const Text(
          'Des',
          style: textStyle,
        );
        break;

      default:
        text = const Text(
          '',
          style: textStyle,
        );
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 1,
      child: text,
    );
  }
}
