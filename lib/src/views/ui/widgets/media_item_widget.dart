import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class MediaItemWidget extends StatefulWidget {
  const MediaItemWidget({
    super.key,
    required this.mediaUrl,
    required this.isShowControls,
  });

  final String mediaUrl;
  final bool isShowControls;

  @override
  State<MediaItemWidget> createState() => _MediaItemWidgetState();
}

class _MediaItemWidgetState extends State<MediaItemWidget> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _customVideoController;
  bool _isVideoLoading = false;
  String _mediaType = '';

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController?.dispose();
    _customVideoController?.dispose();
  }

  Future<void> _initVideoPlayer() async {
    if (widget.mediaUrl.contains('.mp4') || widget.mediaUrl.contains('.temp')) {
      _mediaType = 'VIDEO';
      _videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.mediaUrl));
      await _videoPlayerController!.initialize();
      _customVideoController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        looping: true,
        aspectRatio: _videoPlayerController!.value.aspectRatio,
        showControls: widget.isShowControls,
      );
      _isVideoLoading = true;
      setState(() {});
      return;
    }
    _mediaType = 'IMAGE';
  }

  @override
  Widget build(BuildContext context) {
    final double screenWith = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWith,
      height: screenWith,
      child: _mediaType == 'VIDEO'
          ? _isVideoLoading
              ? Chewie(controller: _customVideoController!)
              : const SizedBox()
          : CachedNetworkImage(
              imageUrl: widget.mediaUrl,
              fit: BoxFit.cover,
            ),
    );
  }
}
