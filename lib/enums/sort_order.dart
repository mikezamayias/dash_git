import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SortOrder {
  ascending,
  descending,
  unsorted,
}

final sortOrderProvider = StateProvider<SortOrder>((ref) => SortOrder.unsorted);
