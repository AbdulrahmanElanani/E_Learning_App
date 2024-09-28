import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/programming_course.dart';

class CartNotifier extends StateNotifier<List<ProgrammingCourse>> {
  CartNotifier() : super([]);

  void toggleCart(ProgrammingCourse course) {
    bool isSelected = state.contains(course);
    if (isSelected) {
      state = state.where((e) => e.id != course.id).toList();
    } else {
      state = [...state, course];
    }
  }
}

final cartProvidier =
    StateNotifierProvider<CartNotifier, List<ProgrammingCourse>>(
  (ref) {
    return CartNotifier();
  },
);
