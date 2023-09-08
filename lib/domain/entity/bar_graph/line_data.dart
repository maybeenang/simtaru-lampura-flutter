import 'package:flutter_map_simtaru/domain/entity/bar_graph/individual_graph.dart';

class LineData {
  List<IndividualBar> barData = [];
  void getData() {
    barData = [
      IndividualBar(1, 56),
      IndividualBar(2, 15),
      IndividualBar(3, 87),
      IndividualBar(4, 23),
      IndividualBar(5, 100),
    ];
  }
}
