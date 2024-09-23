import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:video_player/video_player.dart';

import '../../../business_logic/models/media_type.dart';
import '../../../business_logic/models/preview_media_argument.dart';
import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';
import '../../utils/route_constant.dart';
import '../../utils/string_constant.dart';

class AddLibraryScreen extends StatefulWidget {
  const AddLibraryScreen({super.key});

  @override
  State<AddLibraryScreen> createState() => _AddLibraryScreenState();
}

class _AddLibraryScreenState extends State<AddLibraryScreen> {
  List<AssetEntity> _mediaList = <AssetEntity>[];
  AssetEntity? _entityChoosed;
  VideoPlayerController? _videoPlayerController;
  ChewieController? _customVideoController;

  Future<void> _chooseEntity(AssetEntity entityChoosed) async {
    _entityChoosed = entityChoosed;
    if (_videoPlayerController != null) {
      _videoPlayerController!.dispose();
    }
    if (entityChoosed.type == AssetType.video) {
      final File? videoFile = await _entityChoosed!.file;
      _initVideoPlayer(videoFile);
    } else {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _initMediaLibrary();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController!.dispose();
    _customVideoController!.dispose();
  }

  void _initControls() {
    if (_videoPlayerController!.value.isInitialized) {
      _customVideoController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: true,
        // additionalOptions: (BuildContext context) {
        //   return <OptionItem>[
        //     OptionItem(onTap: () {}, iconData: Icons.add, title: 'Option1'),
        //     OptionItem(onTap: () {}, iconData: Icons.add, title: 'Option1'),
        //   ];
        // },
      );
    }
  }

  void _initVideoPlayer(File? videoFile) {
    if (_videoPlayerController != null) {
      _videoPlayerController!.dispose();
      _customVideoController!.dispose();
    }
    _videoPlayerController = VideoPlayerController.file(File(videoFile!.path))
      ..addListener(
        () => setState(() {}),
      )
      ..initialize().then((_) {
        _customVideoController = ChewieController(
          videoPlayerController: _videoPlayerController!,
          aspectRatio: _videoPlayerController!.value.aspectRatio,
          looping: true,
          autoPlay: true,
        );
        setState(() {});
      });
    _initControls();
    log(videoFile.path);
  }

  Future<void> _initMediaLibrary() async {
    final PermissionState libraryPermission =
        await PhotoManager.requestPermissionExtend();
    if (libraryPermission.isAuth) {
      final int amountOfMedia = await PhotoManager.getAssetCount();
      _mediaList =
          await PhotoManager.getAssetListRange(start: 0, end: amountOfMedia);
      if (_mediaList.isNotEmpty) {
        _entityChoosed = _mediaList[0];
        if (_entityChoosed!.type == AssetType.video) {
          final File? videoFile = await _entityChoosed!.file;
          _initVideoPlayer(videoFile);
        } else {
          setState(() {});
        }
      }
    } else if (libraryPermission.hasAccess) {
      log('fail');
    } else {
      PhotoManager.openSetting();
    }
  }

  Future<void> _navigateToNewPostInputScreen() async {
    await _entityChoosed!.file.then((File? choosenFile) {
      Navigator.of(context).pushNamed(
        RouteConstant.NEW_POST_INFO_INPUT_SCREEN_ROUTE,
        arguments: PreviewMediaArgument(
          path: choosenFile!.path,
          mediaType: MediaType.PICTURE,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: DimensionConstant.SIZE_70,
        leading: Padding(
          padding: const EdgeInsets.only(left: DimensionConstant.SIZE_12),
          child: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text(
                StringConstant.CANCEL_LABEL,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: DimensionConstant.SIZE_15,
                    ),
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          StringConstant.NEW_POST_LABEL,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontSize: DimensionConstant.SIZE_16),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: ColorConstant.FF3897F0,
            ),
            onPressed: () {
              _navigateToNewPostInputScreen();
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
      body: SafeArea(
        child: _entityChoosed != null
            ? Column(
                children: <Widget>[
                  Expanded(
                    child: _entityChoosed!.type == AssetType.video
                        ? AspectRatio(
                            aspectRatio:
                                _videoPlayerController!.value.aspectRatio,
                            child: Chewie(controller: _customVideoController!),
                          )
                        : Image(
                            image: AssetEntityImageProvider(
                              _entityChoosed!,
                              isOriginal: false,
                            ),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                  ),
                  Expanded(
                    child: GridView.count(
                      mainAxisSpacing: DimensionConstant.SIZE_1,
                      crossAxisSpacing: DimensionConstant.SIZE_1,
                      crossAxisCount: 4,
                      children: _mediaList
                          .map(
                            (AssetEntity e) => GestureDetector(
                              onTap: () {
                                _chooseEntity(e);
                              },
                              child: Image(
                                image: AssetEntityImageProvider(
                                  e,
                                  isOriginal: false,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              )
            : const SizedBox(),
      ),
    );
  }
}
