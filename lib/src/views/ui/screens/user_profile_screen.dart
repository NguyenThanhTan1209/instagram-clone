import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../business_logic/blocs/user/user_bloc.dart';
import '../../../business_logic/blocs/user/user_event.dart';
import '../../../business_logic/blocs/user/user_state.dart';
import '../../../business_logic/blocs/user_post_list/user_post_list_bloc.dart';
import '../../../business_logic/blocs/user_post_list/user_post_list_event.dart';
import '../../../business_logic/blocs/user_post_list/user_post_list_state.dart';
import '../../../business_logic/models/post.dart';
import '../../../business_logic/models/user.dart';
import '../../../business_logic/services/authentication_provider.dart';
import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';
import '../../utils/path_constant.dart';
import '../../utils/route_constant.dart';
import '../../utils/string_constant.dart';
import '../widgets/drawer_list_item_widget.dart';
import '../widgets/media_item_widget.dart';
import '../widgets/profile_infomation_column_widget.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with SingleTickerProviderStateMixin{
  final int _profileContentLength = 2;
  late final TabController _tabController;
  final List<Map<String, String>> _iconPathDatas = <Map<String, String>>[
    <String, String>{
      'title': 'Archive',
      'iconPath': PathConstant.ARCHIVE_ICON_PATH,
    },
    <String, String>{
      'title': 'Your Activity',
      'iconPath': PathConstant.ACTIVITY_ICON_PATH,
    },
    <String, String>{
      'title': 'Nametag',
      'iconPath': PathConstant.NAMETAG_ICON_PATH,
    },
    <String, String>{
      'title': 'Saved',
      'iconPath': PathConstant.SAVED_POST_ICON_PATH,
    },
    <String, String>{
      'title': 'Close Friends',
      'iconPath': PathConstant.CLOSE_FRIEND_LIST_ICON_PATH,
    },
    <String, String>{
      'title': 'Discover People',
      'iconPath': PathConstant.DISCOVER_PEOPLE_ICON_PATH,
    },
    <String, String>{
      'title': 'Open Facebook',
      'iconPath': PathConstant.OPEN_FACEBOOK_ICON_PATH,
    },
    <String, String>{
      'title': 'Covid-19 Information Center',
      'iconPath': PathConstant.COVID_CENTER_ICON_PATH,
    },
  ];
  final Map<String, String> settingItem = <String, String>{
    'title': 'Setting',
    'iconPath': PathConstant.SETTING_ICON_PATH,
  };

  @override
  void initState() {
    super.initState();
    context
        .read<UserBloc>()
        .add(GetUserByID(userID: AuthenticationProvider().currentUser!.uid));
    context.read<UserPostListBloc>().add(
          GetPostListByUserID(
            userID: AuthenticationProvider().currentUser!.uid,
          ),
        );
    _tabController = TabController(length: _profileContentLength, vsync: this);
  }

  void _navigateEditProfileScreen(UserModel userModel) {
    Navigator.of(context).pushNamed(
      RouteConstant.EDIT_PROFILE_SCREEN_ROUTE,
      arguments: userModel,
    );
  }

  void _navigateToAddPostScreen() {
    Navigator.of(context).pushNamed(RouteConstant.ADD_POST_SCREEN_ROUTE);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        shape: const RoundedRectangleBorder(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return DrawerListItem(
                    title: _iconPathDatas[index]['title']!,
                    iconPath: _iconPathDatas[index]['iconPath']!,
                  );
                },
                itemCount: _iconPathDatas.length,
              ),
            ),
            DrawerListItem(
              title: settingItem['title'] ?? '',
              iconPath: settingItem['iconPath'] ?? '',
            ),
          ],
        ),
      ),
      backgroundColor: ColorConstant.FAFAFA,
      body: DefaultTabController(
        length: 2,
        child: BlocBuilder<UserBloc, UserState>(
          builder: (BuildContext context, UserState state) {
            if (state is UserSuccessState) {
              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      backgroundColor: ColorConstant.FAFAFA,
                      floating: true,
                      flexibleSpace: FlexibleSpaceBar(
                        title: SizedBox(
                          height: double.infinity,
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                PathConstant.INSTAGRAM_ROUNDED_ICON_PATH,
                                width: DimensionConstant.SIZE_24,
                                height: DimensionConstant.SIZE_24,
                              ),
                              const Spacer(),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Image.asset(
                                    PathConstant.PRIVATE_ACCOUNT_ICON_PATH,
                                    width: DimensionConstant.SIZE_8_POINT_75,
                                    height: DimensionConstant.SIZE_11_POINT_75,
                                  ),
                                  const SizedBox(
                                    width: DimensionConstant.SIZE_6,
                                  ),
                                  Text(
                                    state.user.userName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: ColorConstant.FF262626,
                                          fontSize: DimensionConstant.SIZE_16,
                                        ),
                                  ),
                                  const SizedBox(
                                    width: DimensionConstant.SIZE_5,
                                  ),
                                  Image.asset(
                                    PathConstant
                                        .ACCOUNT_LIST_DROPDOWN_ICON_PATH,
                                    width: DimensionConstant.SIZE_10_POINT_2,
                                    height: DimensionConstant.SIZE_6_POINT_7,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  InkWell(
                                    onTap: _navigateToAddPostScreen,
                                    child: Image.asset(
                                      PathConstant.ADD_MEDIUM_BUTTON_ICON_PATH,
                                      width: DimensionConstant.SIZE_18,
                                      height: DimensionConstant.SIZE_18,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: DimensionConstant.SIZE_17_POINT_5,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: DimensionConstant.SIZE_17_POINT_5,
                              ),
                            ],
                          ),
                        ),
                        titlePadding: const EdgeInsets.symmetric(
                          horizontal: DimensionConstant.SIZE_16,
                          vertical: DimensionConstant.SIZE_10,
                        ),
                      ),
                    ),
                    SliverList.list(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            left: DimensionConstant.SIZE_16,
                            right: DimensionConstant.SIZE_28,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: DimensionConstant.SIZE_86,
                                    height: DimensionConstant.SIZE_86,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: ColorConstant.C7C7CC,
                                        width: DimensionConstant.SIZE_1_POINT_5,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(
                                      DimensionConstant.SIZE_5,
                                    ),
                                    child: CircleAvatar(
                                      backgroundImage: state
                                              .user.avatarPath.isNotEmpty
                                          ? NetworkImage(state.user.avatarPath)
                                          : const AssetImage(
                                              PathConstant
                                                  .DEFAULT_AVATAR_IMAGE_PATH,
                                            ) as ImageProvider,
                                    ),
                                  ),
                                  // const Spacer(),
                                  ProfileInfoColumnWidget(
                                    number: state.user.posts.length,
                                    label: StringConstant.POSTS_LABEL,
                                  ),
                                  // const Spacer(),
                                  ProfileInfoColumnWidget(
                                    number: state.user.followers.length,
                                    label: StringConstant.FOLLOWERS_LABEL,
                                  ),
                                  // const Spacer(),
                                  ProfileInfoColumnWidget(
                                    number: state.user.followings.length,
                                    label: StringConstant.FOLLOWING_LABEL,
                                  ),
                                  // const Spacer(),
                                ],
                              ),
                              const SizedBox(
                                height: DimensionConstant.SIZE_12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    state.user.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: DimensionConstant.SIZE_12,
                                          color: ColorConstant.FF262626,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: DimensionConstant.SIZE_2,
                                  ),
                                  Text(
                                    state.user.bio,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: DimensionConstant.SIZE_12,
                                          color: ColorConstant.FF262626,
                                        ),
                                  ),
                                  InkWell(
                                    child: Text(
                                      state.user.website,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontSize: DimensionConstant.SIZE_12,
                                            color: ColorConstant.FF05386B,
                                          ),
                                    ),
                                    onTap: () => launchUrlString(
                                      state.user.website,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: DimensionConstant.SIZE_15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: DimensionConstant.SIZE_16,
                          ),
                          child: OutlinedButton(
                            onPressed: () {
                              _navigateEditProfileScreen(state.user);
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: ColorConstant.FF3C3C43.withOpacity(
                                  DimensionConstant.SIZE_0_POINT_18,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  DimensionConstant.SIZE_12,
                                ),
                              ),
                            ),
                            child: Text(
                              StringConstant.EDIT_PROFILE_BUTTON_LABEL,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: DimensionConstant.SIZE_13,
                                    color: ColorConstant.FF262626,
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: DimensionConstant.SIZE_16,
                        ),
                        Visibility(
                          visible: state.user.storieAlbums.isNotEmpty,
                          child: SizedBox(
                            height: 88,
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: DimensionConstant.SIZE_9,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return index == 0
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                              horizontal:
                                                  DimensionConstant.SIZE_9,
                                            ),
                                            width: DimensionConstant.SIZE_64,
                                            height: DimensionConstant.SIZE_64,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: ColorConstant.C7C7CC,
                                                width: DimensionConstant
                                                    .SIZE_1_POINT_5,
                                              ),
                                            ),
                                            child: Image.asset(
                                              PathConstant
                                                  .ADD_MEDIUM_BUTTON_ICON_PATH,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: DimensionConstant.SIZE_3,
                                          ),
                                          Text(
                                            state.user.storieAlbums[index]
                                                .albumName,
                                          ),
                                        ],
                                      )
                                    : Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                              horizontal:
                                                  DimensionConstant.SIZE_9,
                                            ),
                                            width: DimensionConstant.SIZE_64,
                                            height: DimensionConstant.SIZE_64,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: ColorConstant.C7C7CC,
                                                width: DimensionConstant
                                                    .SIZE_1_POINT_5,
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(
                                              DimensionConstant.SIZE_4,
                                            ),
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                state
                                                    .user
                                                    .storieAlbums[index]
                                                    .stories
                                                    .first
                                                    .storyImagePath,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: DimensionConstant.SIZE_3,
                                          ),
                                          Text(
                                            state.user.storieAlbums[index]
                                                .albumName,
                                          ),
                                        ],
                                      );
                              },
                              itemCount: state.user.storieAlbums.length,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: DimensionConstant.SIZE_15,
                        ),
                      ],
                    ),
                  ];
                },
                body: Column(
                  children: <Widget>[
                    TabBar(
                      controller: _tabController,
                      indicatorColor: ColorConstant.FF262626,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: <Widget>[
                        Tab(
                          child: Image.asset(
                            PathConstant.GRID_SELECT_ICON_PATH,
                          ),
                        ),
                        Tab(
                          child: Image.asset(
                            PathConstant.MENTION_SELECT_ICON_PATH,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                          BlocBuilder<UserPostListBloc, UserPostListState>(
                            builder:
                                (BuildContext context, UserPostListState state) {
                              if (state is UserPostListSuccess) {
                                return GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                  ),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final Post post = state.postList[index];
                                    return GridTile(
                                      child: MediaItemWidget(
                                        mediaUrl: post.media.first,
                                        isShowControls: false,
                                      ),
                                    );
                                  },
                                  itemCount: state.postList.length,
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                          Card(
                            child: ListTile(
                              leading: const Icon(Icons.location_on),
                              title: const Text(
                                'Latitude: 48.09342\nLongitude: 11.23403',
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.my_location),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorConstant.FF833AB4,
                ),
              );
            } else {
              return const Center(
                child: Text('có lỗi xảy ra'),
              );
            }
          },
        ),
      ),
    );
  }
}
