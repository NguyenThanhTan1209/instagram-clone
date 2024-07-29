import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

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
  List<AssetEntity> entities = <AssetEntity>[];
  AssetEntity? _entityChoosed;

  void _chooseEntity(AssetEntity entityChoosed) {
    setState(() {
      _entityChoosed = entityChoosed;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkPhotoAccess();
  }

  Future<void> _checkPhotoAccess() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    log('test');
    if (ps.isAuth) {
      final int count = await PhotoManager.getAssetCount();
      log('count: $count');
      entities = await PhotoManager.getAssetListRange(start: 0, end: count);
      _entityChoosed = entities[0];
      setState(() {});
    } else if (ps.hasAccess) {
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
      body: Column(
        //su dung nestedscrollview giong user profile screen
        children: <Widget>[
          Expanded(
            child: _entityChoosed != null
                ? Image(
                    image: AssetEntityImageProvider(
                      _entityChoosed!,
                      isOriginal: false,
                    ),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  )
                : const SizedBox(),
          ),
          Expanded(
            child: GridView.count(
              mainAxisSpacing: DimensionConstant.SIZE_1,
              crossAxisSpacing: DimensionConstant.SIZE_1,
              crossAxisCount: 4,
              children: entities
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
      ),
    );
  }
}
