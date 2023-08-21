import 'package:equatable/equatable.dart';

class IndexScreen extends Equatable {
  const IndexScreen({
    this.index = 0,
  });

  final int index;

  IndexScreen copyWith({
    int? index,
  }) {
    return IndexScreen(
      index: index ?? this.index,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [index];
}
