import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_1st/screens/course_videos.dart';
import '../model/programming_course.dart';
import '../providers/cart_provider.dart';
import 'package:http/http.dart' as http;
import '../providers/favourites_provider.dart';

class CourseDetails extends ConsumerStatefulWidget {
  const CourseDetails({super.key, required this.programmingCourse});

  final ProgrammingCourse programmingCourse;

  @override
  ConsumerState<CourseDetails> createState() => _CourseDetailsState();
}

String addOrRemove = 'Add to Cart';
String enroll = "Enroll Now";

class _CourseDetailsState extends ConsumerState<CourseDetails> {
  @override
  void initState() {
    fetchYouTubePlaylistVideos();
    super.initState();
  }

  List<String> videoIds = [];
  List<String> videoUrls = [];
  final String apiKey = 'AIzaSyA8itJq6qOHWdchrDkhOMI21UExsLX0Gio';
  void convertBetweenAddOrRemove() {
    if (addOrRemove == 'Add to Cart') {
      setState(() {
        addOrRemove = 'Remove from cart';
      });
    } else {
      setState(() {
        addOrRemove = 'Add to Cart';
      });
    }
  }

  String extractPlaylistId(String url) {
    final Uri uri = Uri.parse(url);

    // Check if the URL is from youtube.com and contains "playlist"
    if (uri.host == 'www.youtube.com' || uri.host == 'youtube.com') {
      // Extract playlist ID from the query parameters
      return uri.queryParameters['list'] ?? '';
    }

    // Check for shortened URLs (though uncommon for playlists)
    if (uri.host == 'youtu.be') {
      return uri.pathSegments[0]; // This will return the segment after the /
    }

    return ''; // Return an empty string if no valid ID is found
  }

  // Fetch videos from the playlist
  Future<void> fetchYouTubePlaylistVideos() async {
    final url = Uri.parse(
      'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=${extractPlaylistId(widget.programmingCourse.link)}&key=$apiKey',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List videos = data['items'];
        // Extract video URLs
        setState(() {
          videoUrls = videos.map<String>((video) {
            final videoId = video['snippet']['resourceId']['videoId'];
            videoIds.add(videoId);
            return 'https://www.youtube.com/watch?v=$videoId'; // Construct the video URL
          }).toList();
        });
      } else {
        print('Failed to load playlist videos');
      }
    } catch (e) {
      print('Error fetching playlist videos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var favouriteCourses = ref.watch(favouriteCourseProvidier);
    var isCourseExist = favouriteCourses.contains(widget.programmingCourse);

    var cartCourses = ref.watch(cartProvidier);
    cartCourses.contains(widget.programmingCourse);
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: widget.programmingCourse.id,
          child: Text(
            widget.programmingCourse.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .onPrimaryContainer
                    .withOpacity(.2),
              ),
              onPressed: () {
                ref
                    .read(favouriteCourseProvidier.notifier)
                    .toggleFavorite(widget.programmingCourse);
              },
              icon: Icon(
                isCourseExist ? Icons.favorite : Icons.favorite_border,
                color: Colors.red[400],
              ))
        ],
      ),
      body: videoUrls.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Card(
                margin: const EdgeInsets.all(16),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Thumbnail or course image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Hero(
                          tag: videoIds[0],
                          child: Image.network(
                            'https://img.youtube.com/vi/${videoIds[0]}/0.jpg', // Thumbnail from YouTube
                            width: MediaQuery.of(context).size.width * .9,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Description section
                      Text(
                        widget.programmingCourse.description,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Divider to create separation
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                      ),
                      const SizedBox(height: 8),

                      // Outlines section
                      const Text(
                        'Course Outline:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Display the outlines in a bullet list format
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            widget.programmingCourse.outlines.map((outline) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '\u2022', // Bullet point
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    outline,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),

                      // Divider to create separation
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                      ),
                      const SizedBox(height: 8),

                      // Duration and link section with icons
                      Row(
                        children: [
                          const Icon(Icons.timer, color: Colors.blueAccent),
                          const SizedBox(width: 6),
                          Text(
                            '${widget.programmingCourse.duration} h',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Price section with bold styling
                      Text(
                        'Price: \$${widget.programmingCourse.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Divider for separating buttons
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                      ),
                      const SizedBox(height: 12),

                      // Buttons section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              ref
                                  .read(cartProvidier.notifier)
                                  .toggleCart(widget.programmingCourse);
                              convertBetweenAddOrRemove();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors
                                  .white, // Color for the add to cart button
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                            ),
                            icon: const Icon(Icons.shopping_cart),
                            label: Text(addOrRemove),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              if (enroll == "Enroll Now") {
                                setState(() {
                                  widget.programmingCourse.enrolled = true;
                                });
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CourseVideos(
                                            programmingCourse:
                                                widget.programmingCourse,
                                          )));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 224, 47, 34),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                            ),
                            icon: const Icon(Icons.check_circle),
                            label: Text(!widget.programmingCourse.enrolled
                                ? "Enroll Now"
                                : "Enrolled \nGo to Videos"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
