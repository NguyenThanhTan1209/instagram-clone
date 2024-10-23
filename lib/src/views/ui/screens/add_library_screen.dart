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

const int PAGINATION_END_VALUE = 19;

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
  ScrollController? _libraryController;
  int _paginationStartValue = 0;
  int _paginationEndValue = PAGINATION_END_VALUE;
  int _amountOfMedia = 0;

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
    _libraryController!.dispose();
  }

  Future<void> _initVideoPlayer(File? videoFile) async {
    if (_videoPlayerController != null) {
      _videoPlayerController!.dispose();
      _customVideoController!.dispose();
    }
    _videoPlayerController = VideoPlayerController.file(File(videoFile!.path));
    await _videoPlayerController!.initialize();
    _customVideoController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      looping: true,
      aspectRatio: _videoPlayerController!.value.aspectRatio,
    );
    setState(() {});
  }

  Future<void> _initMediaLibrary() async {
    final PermissionState libraryPermission =
        await PhotoManager.requestPermissionExtend();
    if (libraryPermission.isAuth) {
      _amountOfMedia = await PhotoManager.getAssetCount();
      _libraryController = ScrollController();
      _libraryController!.addListener(() {
        fetchMediaLibrary();
      });

      _mediaList = await PhotoManager.getAssetListRange(
        start: _paginationStartValue,
        end: _paginationEndValue,
        type: RequestType.image,
      );

      if (_mediaList.isNotEmpty) {
        _chooseEntity(_mediaList[0]);
      }
    } else if (libraryPermission.hasAccess) {
      log('fail');
    } else {
      PhotoManager.openSetting();
    }
  }

  Future<void> fetchMediaLibrary() async {
    if (_libraryController!.position.maxScrollExtent ==
            _libraryController!.offset &&
        (_paginationEndValue <= _amountOfMedia - 1)) {
      _paginationStartValue = _paginationEndValue + 1;
      _paginationEndValue = _paginationStartValue + PAGINATION_END_VALUE;
      _mediaList.addAll(
        await PhotoManager.getAssetListRange(
          start: _paginationStartValue,
          end: _paginationEndValue,
          type: RequestType.image,
        ),
      );
      setState(() {});
    }
  }

  Future<void> _navigateToNewPostInputScreen() async {
    await _entityChoosed!.file.then((File? choosenFile) {
      if (choosenFile!.path.split('.').last.contains('mp4')) {
        _customVideoController!.pause();
        Navigator.of(context).pushNamed(
          RouteConstant.NEW_POST_INFO_INPUT_SCREEN_ROUTE,
          arguments: PreviewMediaArgument(
            path: choosenFile.path,
            mediaType: MediaType.VIDEO,
          ),
        );
      } else {
        Navigator.of(context).pushNamed(
          RouteConstant.NEW_POST_INFO_INPUT_SCREEN_ROUTE,
          arguments: PreviewMediaArgument(
            path: choosenFile.path,
            mediaType: MediaType.PICTURE,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.sizeOf(context).width;

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
                  SizedBox(
                    width: deviceWidth,
                    height: deviceWidth,
                    child: _entityChoosed!.type == AssetType.video
                        ? AspectRatio(
                            aspectRatio:
                                _videoPlayerController!.value.aspectRatio,
                            child: Chewie(controller: _customVideoController!),
                          )
                        : Image(
                            image: AssetEntityImageProvider(
                              _entityChoosed!,
                            ),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      controller: _libraryController,
                      padding: const EdgeInsets.all(
                        DimensionConstant.SIZE_1,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: DimensionConstant.SIZE_1,
                        crossAxisSpacing: DimensionConstant.SIZE_1,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final AssetEntity item = _mediaList[index];
                        if (index < _mediaList.length) {
                          return GestureDetector(
                            onTap: () {
                              _chooseEntity(item);
                            },
                            child: GridTile(
                              child: Image(
                                image: AssetEntityImageProvider(
                                  item,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        } else {
                          return const GridTile(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: ColorConstant.FF3897F0,
                              ),
                            ),
                          );
                        }
                      },
                      itemCount: _mediaList.length,
                    ),
                  ),
                ],
              )
            : const SizedBox(),
      ),
    );
  }
}
