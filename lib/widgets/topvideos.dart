import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TopVideoScreen extends StatefulWidget {
  final String id;

  TopVideoScreen({this.id});

  @override
  _TopVideoScreenState createState() => _TopVideoScreenState();
}

class _TopVideoScreenState extends State<TopVideoScreen> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(mute: false, autoPlay: true, isLive: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        onReady: () {
          print('Player is ready.');
        },
      ),
    );
  }
}
