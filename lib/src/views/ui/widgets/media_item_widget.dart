import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MediaItemWidget extends StatefulWidget {
  const MediaItemWidget({super.key, required this.mediaUrl});

  final String mediaUrl;

  @override
  State<MediaItemWidget> createState() => _MediaItemWidgetState();
}

class _MediaItemWidgetState extends State<MediaItemWidget> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _customVideoController;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController!.dispose();
    _customVideoController!.dispose();
  }

  void _initVideoPlayer() {
    if (widget.mediaUrl.split('.').last.contains('mp4')) {
      _videoPlayerController = _videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.mediaUrl))
            ..addListener(
              () => setState(() {}),
            )
            ..initialize().then((_) {
              _customVideoController = ChewieController(
                videoPlayerController: _videoPlayerController!,
                aspectRatio: _videoPlayerController!.value.aspectRatio,
                looping: true,
              );
              setState(() {});
            });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWith = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWith,
      height: screenWith,
      child: widget.mediaUrl.split('.').last.contains('mp4')
          ? Chewie(controller: _customVideoController!)
          : CachedNetworkImage(
              imageUrl: widget.mediaUrl,
              fit: BoxFit.cover,
            ),
    );
  }
}
