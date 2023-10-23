import 'package:flutter_map_simtaru/domain/entity/bar_graph/individual_graph.dart';

class LineData {
  List<IndividualBar> barData = [];
  void getData() {
    barData = [
      IndividualBar(1, 120),
      IndividualBar(2, 109),
      IndividualBar(3, 15),
      IndividualBar(4, 35),
    ];
  }
}
