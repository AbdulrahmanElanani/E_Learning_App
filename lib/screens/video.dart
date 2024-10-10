import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Video extends StatefulWidget {
  String videoId;
  final String videoTitle;
  final String description;
  final int index; // Video Index
  final YoutubePlayerController _controller;
  final void Function(int index) goNext;
  final void Function(int index) goBack;
  Video({
    super.key,
    required this.videoId,
    required this.index,
    required this.videoTitle,
    required this.description,
    required this.goNext,
    required this.goBack,
  }) : _controller = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            enableCaption: true,
            showLiveFullscreenButton: true,
            controlsVisibleAtStart: true,
            autoPlay: false,
            mute: false,
          ),
        );

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark mode background
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          widget.videoTitle,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Align title to center
      ),
      body: Column(
        children: [
          // Video Player
          Container(
            padding: const EdgeInsets.all(10),
            child: YoutubePlayer(
              bottomActions: const [
                FullScreenButton(),
                CurrentPosition(), // Show current position of video
                ProgressBar(
                  isExpanded: true,
                  colors: ProgressBarColors(
                    playedColor: Colors.redAccent,
                    handleColor: Colors.redAccent,
                  ),
                ),
                RemainingDuration(), // Show remaining time
              ],
              topActions: [
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.white),
                  onPressed: () {
                    // Add functionality for settings (optional)
                  },
                ),
              ],
              controller: widget._controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.redAccent,
              onReady: () {
                print('Player is ready.');
              },
            ),
          ),
          // Video Details and Actions
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.videoTitle,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.description,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                          widget.goBack(widget.index);
                        },
                        icon: const Icon(Icons.arrow_back),
                        label: const Text("Previous"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                          widget.goNext(widget.index);
                        },
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text("Next"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
