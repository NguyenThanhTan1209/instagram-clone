import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../business_logic/models/media_type.dart';
import '../../../business_logic/models/preview_media_argument.dart';
import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';
import '../../utils/route_constant.dart';
import '../../utils/string_constant.dart';

class PreviewMediaScreen extends StatefulWidget {
  const PreviewMediaScreen({super.key});

  @override
  State<PreviewMediaScreen> createState() => _PreviewMediaScreenState();
}

class _PreviewMediaScreenState extends State<PreviewMediaScreen> {
  late VideoPlayerController _videoPlayerController;

  Future<void> _initVideoPlayer(String filePath) async {
    _videoPlayerController = VideoPlayerController.file(File(filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
  }

  void _cancelPreview(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _navigateToNewPostInputScreen(PreviewMediaArgument previewFile) {
    Navigator.of(context)
        .pushNamed(RouteConstant.NEW_POST_INFO_INPUT_SCREEN_ROUTE, arguments: previewFile);
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PreviewMediaArgument previewFile =
        ModalRoute.of(context)!.settings.arguments! as PreviewMediaArgument;
    _initVideoPlayer(previewFile.path);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: DimensionConstant.SIZE_65,
        leading: Padding(
          padding: const EdgeInsets.only(left: DimensionConstant.SIZE_10),
          child: Center(
            child: GestureDetector(
              onTap: () {
                _cancelPreview(context);
              },
              child: Text(
                StringConstant.CANCEL_LABEL,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: ColorConstant.FF3897F0,
            ),
            onPressed: () {
              _navigateToNewPostInputScreen(previewFile);
            },
            child: Text(
              StringConstant.NEXT_LABEL,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: DimensionConstant.SIZE_16,
                    color: ColorConstant.FF3897F0,
                  ),
            ),
          ),
        ],
      ),
      backgroundColor: ColorConstant.BLACK,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: DimensionConstant.SIZE_375,
            child: previewFile.mediaType == MediaType.PICTURE
                ? Image.file(
                    File(
                      previewFile.path,
                    ),
                    width: double.infinity,
                    fit: BoxFit.fill,
                  )
                : VideoPlayer(_videoPlayerController),
          ),
        ],
      ),
    );
  }
}
