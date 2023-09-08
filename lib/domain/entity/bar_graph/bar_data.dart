import 'package:flutter_map_simtaru/domain/entity/bar_graph/individual_graph.dart';

class BarData {
  final double jan;
  final double feb;
  final double mar;
  final double apr;
  final double mei;
  final double jun;
  final double jul;
  final double agu;
  final double sep;
  final double okt;
  final double nov;
  final double des;

  BarData({
    required this.jan,
    required this.feb,
    required this.mar,
    required this.apr,
    required this.mei,
    required this.jun,
    required this.jul,
    required this.agu,
    required this.sep,
    required this.okt,
    required this.nov,
    required this.des,
  });

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(1, jan),
      IndividualBar(2, feb),
      IndividualBar(3, mar),
      IndividualBar(4, apr),
      IndividualBar(5, mei),
      IndividualBar(6, jun),
      IndividualBar(7, jul),
      IndividualBar(8, agu),
      IndividualBar(9, sep),
      IndividualBar(10, okt),
      IndividualBar(11, nov),
      IndividualBar(12, des),
    ];
  }
}
