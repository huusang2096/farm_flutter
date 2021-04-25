import 'package:chewie/chewie.dart';
import 'package:farmgate/src/common/config.dart';
import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';
import 'package:video_player/video_player.dart';

class VideoURLWidget extends StatefulWidget {
  final String url;

  const VideoURLWidget({Key key, this.url}) : super(key: key);

  @override
  _VideoURLWidgetState createState() => _VideoURLWidgetState();
}

class _VideoURLWidgetState extends State<VideoURLWidget> {
  VideoPlayerController _videoController;
  ChewieController _chewieController;

  Future<void> initializePlayer() async {
    _videoController = VideoPlayerController.network(widget.url);
    await _videoController.initialize();
    _chewieController = ChewieController(
      errorBuilder: (context, message) {
        return Container(
          child: Center(
              child: Text('video_not_found'.tr,
                  style: TextStyle(color: Colors.white))),
        );
      },
      videoPlayerController: _videoController,
      autoPlay: false,
      looping: true,
    );
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    if (_videoController != null) {
      _videoController.pause();
      _videoController.dispose();
    }
    if (_chewieController != null) {
      _chewieController.dispose();
    }
  }

  @override
  void initState() {
    super.initState();
    this.initializePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _chewieController != null &&
              _chewieController.videoPlayerController.value.initialized
          ? Chewie(
              controller: _chewieController,
            )
          : Stack(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * (9 / 16),
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  right: 0.0,
                  top: 0.0,
                  left: 0.0,
                  bottom: 0.0,
                  child: SpinKitCircle(
                    color: appIconColor,
                    size: 50.0,
                  ),
                )
              ],
            ),
    );
  }
}
