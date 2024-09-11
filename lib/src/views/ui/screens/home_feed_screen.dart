import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/blocs/post_list/post_list_bloc.dart';
import '../../../business_logic/blocs/post_list/post_list_event.dart';
import '../../../business_logic/blocs/post_list/post_list_state.dart';
import '../../../business_logic/models/post.dart';
import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';
import '../../utils/path_constant.dart';
import '../../utils/route_constant.dart';
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
  void initState() {
    super.initState();
    context.read<PostListBloc>().add(GetPostList());
  }

  @override
  Widget build(BuildContext context) {
    final double screenWith = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
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
                InkWell(
                  onTap: _navigateToAddPostScreen,
                  child: Image.asset(
                    PathConstant.ADD_FEED_BUTTON_ICON_PATH,
                    width: DimensionConstant.SIZE_24,
                    height: DimensionConstant.SIZE_24,
                  ),
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
                BlocBuilder<PostListBloc, PostListState>(
                  builder: (BuildContext context, PostListState state) {
                    if (state is PostListInProgress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is PostListFailed) {
                      return Center(
                        child: Text(state.error),
                      );
                    } else if (state is PostListSuccess) {
                      final List<Post> posts = state.postList;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final Post post = posts[index];
                          final ValueNotifier<int> postIndex =
                              ValueNotifier<int>(1);

                          return Column(
                            children: <Widget>[
                              PostTitleWidget(post: post),
                              PostMediaWidget(
                                post: post,
                                screenWith: screenWith,
                                postIndex: postIndex,
                              ),
                              PostFooterWidget(
                                postIndex: postIndex,
                                post: post,
                              ),
                            ],
                          );
                        },
                        itemCount: posts.length,
                      );
                    } else {
                      return Container();
                    }
                  },
                  // builder: (context) {
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToAddPostScreen() {
    Navigator.of(context).pushNamed(RouteConstant.ADD_POST_SCREEN_ROUTE);
  }
}
