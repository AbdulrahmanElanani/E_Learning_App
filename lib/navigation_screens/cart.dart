import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../drawer/mydrawer.dart';
import '../providers/cart_provider.dart';
import '../widgets/course_item.dart';

class Cart extends ConsumerStatefulWidget {
  const Cart({super.key});

  @override
  ConsumerState<Cart> createState() => _CartState();
}

class _CartState extends ConsumerState<Cart> {
  @override
  Widget build(BuildContext context) {
    var cartCourses = ref.watch(cartProvidier);

    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return CourseItem(programmingCourse: cartCourses[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.grey[400],
            height: 1,
          );
        },
        itemCount: cartCourses.length,
      ),
    );
  }
}
