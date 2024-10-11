import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/programming_course.dart';
import '../providers/favourites_provider.dart';
import '../screens/course_details.dart';

class CartItem extends ConsumerStatefulWidget {
  const CartItem({super.key, required this.programmingCourse});

  final ProgrammingCourse programmingCourse;

  @override
  ConsumerState<CartItem> createState() => _CourseItemState();
}

class _CourseItemState extends ConsumerState<CartItem> {
  @override
  Widget build(BuildContext context) {
    var favouriteCourses = ref.watch(favouriteCourseProvidier);
    var isCourseExist = favouriteCourses.contains(widget.programmingCourse);
    return SingleChildScrollView(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (e) =>
                CourseDetails(programmingCourse: widget.programmingCourse),
          ));
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9, // Increased width
          height: MediaQuery.of(context).size.height * 0.9, // Increased height
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // More rounded corners
            ),
            elevation: 10, // Increased elevation for depth
            margin: const EdgeInsets.symmetric(
                horizontal: 15, vertical: 15), // Spacing around the card
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(
                            20)), // Rounded top corners for image
                    child: Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKpIzUJV8BNUc9XMaSXM3Wm114SRLacJnHSg&s", // Assuming imageUrl is a property of programmingCourse
                      height: 150, // Height of the image
                      width: double.infinity, // Full width of the card
                      fit: BoxFit.cover, // Cover the space without distortion
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.all(15.0), // Padding around the text
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align text to the left
                      children: [
                        Text(
                          widget.programmingCourse.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent, // Color for course title
                          ),
                        ),
                        const SizedBox(height: 5), // Spacing
                        Text(
                          widget.programmingCourse.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700], // Color for description
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10), // Spacing
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${widget.programmingCourse.duration}h ",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors
                                            .orangeAccent, // Color for duration
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Icon(
                                      Icons.access_time,
                                      color: Colors.grey[600],
                                      size: 18,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5), // Spacing
                                Text(
                                  "${widget.programmingCourse.price} \$",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.green, // Color for price
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(
                                isCourseExist
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () => ref
                                  .read(favouriteCourseProvidier.notifier)
                                  .toggleFavorite(widget.programmingCourse),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10), // Spacing before button
                        ElevatedButton(
                          onPressed: () {
                            // Implement checkout logic here
                            print(
                                "Proceeding to checkout for ${widget.programmingCourse.name}");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent, // Button color
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12), // Button padding
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded button
                            ),
                          ),
                          child: const Text(
                            "Check Out",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white), // Button text color
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
