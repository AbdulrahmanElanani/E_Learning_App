import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/programming_course.dart';

class FavouriteCourseNotifier extends StateNotifier<List<ProgrammingCourse>> {
  FavouriteCourseNotifier() : super([]);

  void toggleFavorite(ProgrammingCourse course) {
    bool isSelected = state.contains(course);
    if (isSelected) {
      state = state.where((e) => e.id != course.id).toList();
    } else {
      state = [...state, course];
    }
  }
}

final favouriteCourseProvidier =
    StateNotifierProvider<FavouriteCourseNotifier, List<ProgrammingCourse>>(
  (ref) {
    return FavouriteCourseNotifier();
  },
);
