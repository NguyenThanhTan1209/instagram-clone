import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

import '../../../business_logic/blocs/post/post_bloc.dart';
import '../../../business_logic/blocs/post/post_event.dart';
import '../../../business_logic/blocs/post/post_state.dart';
import '../../../business_logic/models/media_type.dart';
import '../../../business_logic/models/post.dart';
import '../../../business_logic/models/preview_media_argument.dart';
import '../../../business_logic/models/user.dart';
import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';
import '../../utils/route_constant.dart';
import '../../utils/string_constant.dart';

class NewPostInfoInputScreen extends StatefulWidget {
  const NewPostInfoInputScreen({super.key});

  @override
  State<NewPostInfoInputScreen> createState() => _NewPostInfoInputScreenState();
}

class _NewPostInfoInputScreenState extends State<NewPostInfoInputScreen> {
  late VideoPlayerController _videoPlayerController;
  late TextEditingController _captionController;
  PreviewMediaArgument? previewFile;
  bool _facebookPostChoice = false;
  bool _twitterPostChoice = false;
  bool _tumblerPostChoice = false;

  Future<void> _initVideoPlayer(PreviewMediaArgument previewFile) async {
    if (previewFile.mediaType == MediaType.VIDEO) {
      _videoPlayerController =
          VideoPlayerController.file(File(previewFile.path));
      await _videoPlayerController.initialize();
      await _videoPlayerController.pause();
    }
  }

  void _cancelPreview(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _sharePost() {
    final UserModel currentUser = UserModel.instance;
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy hh:mm');
    final String createdDate = dateFormat.format(DateTime.now());

    final Post post = Post(
      postID: const Uuid().v4(),
      userID: currentUser.userID,
      userName: currentUser.userName,
      avatarPath: currentUser.avatarPath,
      images: <String>[previewFile!.path],
      comments: <String>[],
      likedUsers: <String>[],
      content: _captionController.text,
      createdDate: createdDate,
    );
    context.read<PostBloc>().add(CreatePost(post: post));
  }

  @override
  void initState() {
    super.initState();
    _captionController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    previewFile =
        ModalRoute.of(context)!.settings.arguments! as PreviewMediaArgument;
    _initVideoPlayer(previewFile!);

    return Scaffold(
      appBar: AppBar(
        shadowColor: ColorConstant.BLACK,
        elevation: DimensionConstant.SIZE_1,
        backgroundColor: ColorConstant.WHITE,
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
        leadingWidth: DimensionConstant.SIZE_65,
        title: Text(
          StringConstant.NEW_POST_LABEL,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontSize: DimensionConstant.SIZE_16),
        ),
        centerTitle: true,
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: ColorConstant.FF3897F0,
            ),
            onPressed: _sharePost,
            child: Text(
              StringConstant.SHARE_LABEL,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: DimensionConstant.SIZE_16,
                    color: ColorConstant.FF3897F0,
                  ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocListener<PostBloc, PostState>(
          listener: (BuildContext context, PostState state) {
            if (state is PostInProgress) {
              showDialog(
                context: context,
                builder: (BuildContext context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is PostSuccess) {
              final SnackBar snackBar = SnackBar(
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Success',
                  message: 'Posted successfully',
                  contentType: ContentType.success,
                ),
              );
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
              Navigator.of(context).pushNamedAndRemoveUntil(
                RouteConstant.HOME_SCREEN_ROUTE,
                (Route<dynamic> route) => false,
              );
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: ColorConstant.EEEEEE),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(DimensionConstant.SIZE_16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: DimensionConstant.SIZE_100,
                          height: DimensionConstant.SIZE_100,
                          child: previewFile!.mediaType == MediaType.VIDEO
                              ? AspectRatio(
                                  aspectRatio:
                                      _videoPlayerController.value.aspectRatio,
                                  child: VideoPlayer(_videoPlayerController),
                                )
                              : Image.file(
                                  File(previewFile!.path),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        const SizedBox(
                          width: DimensionConstant.SIZE_16,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _captionController,
                            keyboardType: TextInputType.multiline,
                            maxLines: DimensionConstant.SIZE_10.toInt(),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              hintText: 'Write a caption...',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: ColorConstant.EEEEEE),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(DimensionConstant.SIZE_16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          StringConstant.TAG_PEOPLE_LABEL,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const Icon(Icons.chevron_right_rounded),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: ColorConstant.EEEEEE),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(DimensionConstant.SIZE_16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          StringConstant.ADD_LOCATION_LABEL,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const Icon(Icons.chevron_right_rounded),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: ColorConstant.EEEEEE),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(DimensionConstant.SIZE_16),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              StringConstant.FACEBOOK_LABEL,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            CupertinoSwitch(
                              value: _facebookPostChoice,
                              onChanged: (bool value) {
                                setState(() {
                                  _facebookPostChoice = value;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: DimensionConstant.SIZE_16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              StringConstant.TWITTER_LABEL,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            CupertinoSwitch(
                              value: _twitterPostChoice,
                              onChanged: (bool value) {
                                setState(() {
                                  _twitterPostChoice = value;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: DimensionConstant.SIZE_16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              StringConstant.TUMBLUR_LABEL,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            CupertinoSwitch(
                              value: _tumblerPostChoice,
                              onChanged: (bool value) {
                                setState(() {
                                  _tumblerPostChoice = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
