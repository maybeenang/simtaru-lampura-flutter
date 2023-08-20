import 'package:flutter_map_simtaru/bar_graph/individual_graph.dart';

class LineData {
  List<IndividualBar> barData = [];
  void getData() {
    barData = [
      IndividualBar(1, 20),
      IndividualBar(2, 12),
      IndividualBar(3, 36),
    ];
  }
}
