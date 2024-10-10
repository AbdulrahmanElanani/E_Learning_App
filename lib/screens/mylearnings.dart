import 'package:flutter/material.dart';
import 'package:project_1st/data/course_data.dart';
import 'package:project_1st/model/programming_course.dart';
import 'package:project_1st/widgets/course_item.dart';

class Mylearnings extends StatelessWidget {
  Mylearnings({super.key});
  List<ProgrammingCourse> enrolledCourses =
      programmingCourses.where((e) => e.enrolled == true).toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: enrolledCourses.length,
        itemBuilder: (context, index) {
          return CourseItem(programmingCourse: enrolledCourses[index]);
        },
      ),
    );
  }
}
