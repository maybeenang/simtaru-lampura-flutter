import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_simtaru/bar_graph/line_data.dart';
import 'package:flutter_map_simtaru/constants/colors.dart';
import 'package:flutter_map_simtaru/constants/double.dart';

class CustomLineChart extends StatelessWidget {
  const CustomLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    LineData lineData = LineData();
    lineData.getData();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(AppDouble.borderRadius),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppDouble.borderRadius),
          ),
          child: Column(
            children: [
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "Grafik Pengajuan Petahun",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 20),
              AspectRatio(
                aspectRatio: 2,
                child: LineChart(
                  LineChartData(
                    maxY: lineData.barData
                        .map((data) => data.y)
                        .toList()
                        .reduce((value, element) =>
                            value > element ? value : element),
                    minY: 0,
                    borderData: FlBorderData(
                      show: true,
                      border: const Border(
                        left: BorderSide.none,
                        bottom: BorderSide.none,
                        right: BorderSide.none,
                        top: BorderSide.none,
                      ),
                    ),
                    gridData: const FlGridData(
                      drawVerticalLine: false,
                    ),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: getBottomTitles,
                          interval: 1,
                        ),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 25,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: lineData.barData
                            .map(
                              (point) => FlSpot(point.x.toDouble(), point.y),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
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
          '2018',
          style: textStyle,
        );
        break;
      case 2:
        text = const Text(
          '2019',
          style: textStyle,
        );
        break;
      case 3:
        text = const Text(
          '2020',
          style: textStyle,
        );
        break;
      case 4:
        text = const Text(
          '2021',
          style: textStyle,
        );
        break;
      case 5:
        text = const Text(
          '2022',
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
