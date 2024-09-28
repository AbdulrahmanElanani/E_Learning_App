import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../drawer/mydrawer.dart';
import '../providers/favourites_provider.dart';
import '../widgets/course_item.dart';

class Favourite extends ConsumerStatefulWidget {
  const Favourite({super.key});

  @override
  ConsumerState<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends ConsumerState<Favourite> {
  @override
  Widget build(BuildContext context) {
    var favouriteCourses = ref.watch(favouriteCourseProvidier);
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text("Favourite"),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return CourseItem(programmingCourse: favouriteCourses[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.grey[400],
            height: 1,
          );
        },
        itemCount: favouriteCourses.length,
      ),
    );
  }
}
