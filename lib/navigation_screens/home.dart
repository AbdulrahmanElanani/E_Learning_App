import 'package:flutter/material.dart';

import '../data/course_data.dart';
import '../drawer/mydrawer.dart';
import '../widgets/course_item.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const MyDrawer(),
        appBar: AppBar(
          title: const Text("Home"),
        ),
        body: ListView.separated(
          itemBuilder: (context, index) {
            return CourseItem(programmingCourse: programmingCourses[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.grey[400],
              height: 1,
            );
          },
          itemCount: programmingCourses.length,
        ));
  }
}
