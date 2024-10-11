import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/programming_course.dart';
import '../providers/favourites_provider.dart';
import '../screens/course_details.dart';

class CourseItem extends ConsumerStatefulWidget {
  const CourseItem({super.key, required this.programmingCourse});

  final ProgrammingCourse programmingCourse;

  @override
  ConsumerState<CourseItem> createState() => _CourseItemState();
}

class _CourseItemState extends ConsumerState<CourseItem> {
  @override
  Widget build(BuildContext context) {
    var favouriteCourses = ref.watch(favouriteCourseProvidier);
    var isCourseExist = favouriteCourses.contains(widget.programmingCourse);
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (e) =>
                  CourseDetails(programmingCourse: widget.programmingCourse)));
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 5,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Rounded corners
            ),
            elevation: 5, // Add a subtle shadow for depth
            margin: const EdgeInsets.symmetric(
                horizontal: 15, vertical: 10), // Add margin around the card
            child: Padding(
              // Add padding inside the card
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  // Add an Icon or image at the start (Optional)
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blueAccent, // Background color
                    child: Icon(
                      Icons.code, // Icon representing the course
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 15), // Spacing between icon and text
                  Expanded(
                    // Allow text to expand to fill available space
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align text to the start
                      children: [
                        Expanded(
                          child: Hero(
                            tag: widget.programmingCourse.id,
                            child: Text(
                              widget.programmingCourse.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight:
                                    FontWeight.bold, // Bold title for emphasis
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                            height: 5), // Spacing between title and subtitle
                        Expanded(
                          child: Text(
                            widget.programmingCourse.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[
                                  600], // Subtle color for the description
                            ),
                            maxLines: 2, // Limit to 2 lines
                            overflow: TextOverflow
                                .ellipsis, // Add ellipsis if the text is too long
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                      width: 10), // Spacing between text and trailing
                  Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .end, // Align trailing text to the end
                    children: [
                      IconButton(
                        icon: Icon(
                          isCourseExist
                              ? Icons.favorite
                              : Icons
                                  .favorite_border, // Use a border to show it's not favorited yet
                          color: Colors.red, // Red color for the favorite icon
                        ),
                        onPressed: () => ref
                            .read(favouriteCourseProvidier.notifier)
                            .toggleFavorite(widget.programmingCourse),
                      ),
                      Row(
                        children: [
                          Text(
                            "${widget.programmingCourse.duration}h ",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors
                                  .blueAccent, // Highlighted color for duration
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
                      const SizedBox(height: 5),
                      Text(
                        "${widget.programmingCourse.price} \$", // Display the price here
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.green, // Highlight the price in green
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Spacing between price and favorite icon
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
