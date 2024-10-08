import 'package:flutter_map_simtaru/domain/entity/index_screen/index_screen.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

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
