import 'package:flutter_map_simtaru/bar_graph/individual_graph.dart';

class LineData {
  List<IndividualBar> barData = [];
  void getData() {
    barData = [
      IndividualBar(1, 56),
      IndividualBar(2, 123),
      IndividualBar(3, 87),
      IndividualBar(4, 23),
      IndividualBar(5, 90),
    ];
  }
}
