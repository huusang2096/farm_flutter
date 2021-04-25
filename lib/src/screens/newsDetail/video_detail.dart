import 'package:farmgate/src/common/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simplest/simplest.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDetail extends StatefulWidget {
  String videoLink;
  Duration position;
  VideoDetail({this.videoLink, this.position});

  @override
  _VideoDetailState createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  YoutubePlayerController _controller;
  int secondStart;
  bool isShowBack = true;
  final _debouncer = Debouncer(milliseconds: 200);

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoLink),
      flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: true,
          isLive: false,
          forceHD: false,
          enableCaption: true),
    );
    _debouncer.run(() {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    });
    super.initState();
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        onEnterFullScreen: () {
          _debouncer.run(() {
            _controller.play();
          });
        },
        onExitFullScreen: () {
          _debouncer.run(() {
            Navigator.of(context).pop(_controller.value.position);
          });
        },
        player: YoutubePlayer(
          controller: _controller,
          progressIndicatorColor: appIconColor,
          showVideoProgressIndicator: true,
          onReady: () {
            if (widget.position != null) {
              _controller.seekTo(widget.position);
            }
          },
        ),
        builder: (context, player) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              player,
            ],
          );
        });
  }
}
