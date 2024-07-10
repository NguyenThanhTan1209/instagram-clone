import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../business_logic/models/media_type.dart';
import '../../../business_logic/models/preview_media_argument.dart';
import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';
import '../../utils/path_constant.dart';
import '../../utils/route_constant.dart';
import '../../utils/string_constant.dart';

class AddPhotoScreen extends StatefulWidget {
  const AddPhotoScreen({super.key});

  @override
  State<AddPhotoScreen> createState() => _AddPhotoScreenState();
}

class _AddPhotoScreenState extends State<AddPhotoScreen> {
  late final List<CameraDescription> _cameras;
  late CameraDescription _currentCamera;
  late CameraController _cameraController;
  Future<void>? _initializeControllerFuture;
  bool _isFlashOn = false;
  late XFile? _image;

  @override
  void initState() {
    super.initState();
    _startCamera();
  }

  Future<void> _startCamera() async {
    _cameras = await availableCameras();
    _currentCamera = _cameras.first;
    _cameraController = CameraController(
      _currentCamera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _cameraController.initialize();
    setState(() {
      
    });
  }

  void _switchCameraFlash() {
    if (_isFlashOn) {
      _cameraController.setFlashMode(FlashMode.off);
    } else {
      _cameraController.setFlashMode(FlashMode.torch);
    }
    _isFlashOn = !_isFlashOn;
    setState(() {});
  }

  void _switchCamera() {
    if (_currentCamera == _cameras.first) {
      _currentCamera = _cameras.last;
    } else {
      _currentCamera = _cameras.first;
    }
    _cameraController = CameraController(_currentCamera, ResolutionPreset.high);
    _initializeControllerFuture = _cameraController.initialize();
    setState(() {});
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      _image = await _cameraController.takePicture();
      _cameraController.setFlashMode(FlashMode.off);
      if (context.mounted) {
        Navigator.of(context).pushNamed(
          RouteConstant.PREVIEW_PICTURE_SCREEN_ROUTE,
          arguments: PreviewMediaArgument(path: _image!.path, mediaType: MediaType.PICTURE),
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
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
                      fontSize: DimensionConstant.SIZE_16,
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
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: DimensionConstant.SIZE_375,
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      CameraPreview(_cameraController),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(
                            DimensionConstant.SIZE_16,
                          ),
                          child: GestureDetector(
                            onTap: _switchCamera,
                            child: Image.asset(
                              PathConstant.SWAP_CAMERA_ICON_PATH,
                              width: DimensionConstant.SIZE_30,
                              height: DimensionConstant.SIZE_30,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(
                            DimensionConstant.SIZE_16,
                          ),
                          child: GestureDetector(
                            onTap: _switchCameraFlash,
                            child: Image.asset(
                              _isFlashOn
                                  ? PathConstant.FLASH_ICON_PATH
                                  : PathConstant.NO_FLASH_ICON_PATH,
                              width: DimensionConstant.SIZE_30,
                              height: DimensionConstant.SIZE_30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Expanded(
            child: Center(
              child: InkWell(
                onTap: _takePicture,
                child: Container(
                  width: DimensionConstant.SIZE_87,
                  height: DimensionConstant.SIZE_87,
                  decoration: BoxDecoration(
                    color: ColorConstant.WHITE,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: DimensionConstant.SIZE_14,
                      color: ColorConstant.CCCCCC,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
