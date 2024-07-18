import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../business_logic/models/post.dart';
import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';
import '../../utils/path_constant.dart';
import '../widgets/post_footer_widget.dart';
import '../widgets/post_media_widget.dart';
import '../widgets/post_title_widget.dart';
import '../widgets/story_item_widget.dart';

class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({super.key});

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenWith = MediaQuery.of(context).size.width;
    final List<Post> posts = <Post>[
      Post(
        postID: '11',
        userID: '1212',
        userName: 'tan_newc',
        images: <String>[
          'https://file3.qdnd.vn/data/images/0/2022/11/14/hieu_tv/dt%20phap%201.jpg',
          'https://cdnmedia.baotintuc.vn/2018/07/16/06/30/1607-Phap-2.jpg',
          'https://media-cdn-v2.laodong.vn/Storage/newsportal/2018/7/16/618920/Nnzwdmr6adpz6ait33hk.jpg',
        ],
      ),
      Post(
        postID: '12',
        userID: '1212',
        userName: 'fernando',
        images: <String>[
          'https://file3.qdnd.vn/data/images/0/2022/11/14/hieu_tv/dt%20phap%201.jpg',
          'https://cdnmedia.baotintuc.vn/2018/07/16/06/30/1607-Phap-2.jpg',
          'https://media-cdn-v2.laodong.vn/Storage/newsportal/2018/7/16/618920/Nnzwdmr6adpz6ait33hk.jpg',
        ],
      ),
      Post(
        postID: '13',
        userID: '1212',
        userName: 'llyy@22',
        images: <String>[
          'https://file3.qdnd.vn/data/images/0/2022/11/14/hieu_tv/dt%20phap%201.jpg',
          'https://cdnmedia.baotintuc.vn/2018/07/16/06/30/1607-Phap-2.jpg',
          'https://media-cdn-v2.laodong.vn/Storage/newsportal/2018/7/16/618920/Nnzwdmr6adpz6ait33hk.jpg',
        ],
      ),
      Post(
        postID: '14',
        userID: '1212',
        userName: 'beckham12',
        images: <String>[
          'https://file3.qdnd.vn/data/images/0/2022/11/14/hieu_tv/dt%20phap%201.jpg',
          'https://cdnmedia.baotintuc.vn/2018/07/16/06/30/1607-Phap-2.jpg',
          'https://media-cdn-v2.laodong.vn/Storage/newsportal/2018/7/16/618920/Nnzwdmr6adpz6ait33hk.jpg',
        ],
      ),
      Post(
        postID: '11',
        userID: '1212',
        userName: 'tan_newc',
        images: <String>[
          'https://file3.qdnd.vn/data/images/0/2022/11/14/hieu_tv/dt%20phap%201.jpg',
          'https://cdnmedia.baotintuc.vn/2018/07/16/06/30/1607-Phap-2.jpg',
          'https://media-cdn-v2.laodong.vn/Storage/newsportal/2018/7/16/618920/Nnzwdmr6adpz6ait33hk.jpg',
        ],
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: DimensionConstant.SIZE_44,
              backgroundColor: ColorConstant.WHITE,
              title: Image.asset(
                PathConstant.INSTA_BLACK_LOGO_PATH,
                width: DimensionConstant.SIZE_105,
                height: DimensionConstant.SIZE_28,
                fit: BoxFit.contain,
              ),
              centerTitle: true,
              leading: Image.asset(
                PathConstant.CAMERA_ICON_PATH,
                width: DimensionConstant.SIZE_23_POINT_5,
                height: DimensionConstant.SIZE_22,
              ),
              actions: <Widget>[
                Image.asset(
                  PathConstant.ADD_FEED_BUTTON_ICON_PATH,
                  width: DimensionConstant.SIZE_24,
                  height: DimensionConstant.SIZE_24,
                ),
                const SizedBox(width: DimensionConstant.SIZE_17),
                Image.asset(
                  PathConstant.MESSAGE_ICON_PATH,
                  width: DimensionConstant.SIZE_24,
                  height: DimensionConstant.SIZE_24,
                ),
                const SizedBox(width: DimensionConstant.SIZE_16),
              ],
            ),
            SliverList.list(
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: ColorConstant.FF3C3C43,
                        width: DimensionConstant.SIZE_0_POINT_30,
                      ),
                    ),
                  ),
                  height: DimensionConstant.SIZE_106,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimensionConstant.SIZE_10,
                      vertical: DimensionConstant.SIZE_8,
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      width: DimensionConstant.SIZE_20,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return const StoryItemWidget();
                    },
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final Post post = posts[index];
                    final ValueNotifier<int> postIndex = ValueNotifier<int>(1);

                    return Column(
                      children: <Widget>[
                        PostTitleWidget(username: post.userName),
                        PostMediaWidget(
                          post: post,
                          screenWith: screenWith,
                          postIndex: postIndex,
                        ),
                        PostFooterWidget(postIndex: postIndex, post: post),
                      ],
                    );
                  },
                  itemCount: posts.length,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
