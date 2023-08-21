import 'package:flutter_map_simtaru/states/index_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IndexScreenNotifier extends StateNotifier<IndexScreen> {
  IndexScreenNotifier() : super(const IndexScreen());

  void onIndexChange(int index) {
    state = state.copyWith(index: index);
  }
}

final indexScreenProvider =
    StateNotifierProvider<IndexScreenNotifier, IndexScreen>((ref) {
  return IndexScreenNotifier();
});
