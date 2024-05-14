import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../business_logic/models/post.dart';
import '../../../business_logic/models/user.dart';
import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';
import '../../utils/path_constant.dart';
import '../../utils/string_constant.dart';
import '../widgets/profile_infomation_column_widget.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with SingleTickerProviderStateMixin {
  final User currentUser = User.mockData();
  final int profileContentLength = 2;
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: profileContentLength, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.FAFAFA,
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
                              currentUser.userName,
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
                              PathConstant.ACCOUNT_LIST_DROPDOWN_ICON_PATH,
                              width: DimensionConstant.SIZE_10_POINT_2,
                              height: DimensionConstant.SIZE_6_POINT_7,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset(
                              PathConstant.ADD_MEDIUM_BUTTON_ICON_PATH,
                              width: DimensionConstant.SIZE_18,
                              height: DimensionConstant.SIZE_18,
                            ),
                            const SizedBox(
                              width: DimensionConstant.SIZE_17_POINT_5,
                            ),
                            Image.asset(
                              PathConstant.SIDE_MENU_ICON_PATH,
                              width: DimensionConstant.SIZE_17_POINT_5,
                              height: DimensionConstant.SIZE_20_POINT_5,
                            ),
                          ],
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                backgroundImage:
                                    NetworkImage(currentUser.avatarPath),
                              ),
                            ),
                            // const Spacer(),
                            ProfileInfoColumnWidget(
                              number: currentUser.posts.length,
                              label: StringConstant.POSTS_LABEL,
                            ),
                            // const Spacer(),
                            ProfileInfoColumnWidget(
                              number: currentUser.followerTotal,
                              label: StringConstant.FOLLOWERS_LABEL,
                            ),
                            // const Spacer(),
                            ProfileInfoColumnWidget(
                              number: currentUser.followingTotal,
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
                              currentUser.name,
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
                              currentUser.description,
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
                                currentUser.website,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: DimensionConstant.SIZE_12,
                                      color: ColorConstant.FF05386B,
                                    ),
                              ),
                              onTap: () =>
                                  launchUrlString('https://www.example.com'),
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
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: ColorConstant.FF3C3C43
                              .withOpacity(DimensionConstant.SIZE_0_POINT_18),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(DimensionConstant.SIZE_12),
                        ),
                      ),
                      child: Text(
                        StringConstant.EDIT_PROFILE_BUTTON_LABEL,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: DimensionConstant.SIZE_13,
                              color: ColorConstant.FF262626,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: DimensionConstant.SIZE_16,
                  ),
                  SizedBox(
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
                                      horizontal: DimensionConstant.SIZE_9,
                                    ),
                                    width: DimensionConstant.SIZE_64,
                                    height: DimensionConstant.SIZE_64,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: ColorConstant.C7C7CC,
                                        width: DimensionConstant.SIZE_1_POINT_5,
                                      ),
                                    ),
                                    child: Image.asset(
                                      PathConstant.ADD_MEDIUM_BUTTON_ICON_PATH,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: DimensionConstant.SIZE_3,
                                  ),
                                  Text(
                                    currentUser.storieAlbums[index].albumName,
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: DimensionConstant.SIZE_9,
                                    ),
                                    width: DimensionConstant.SIZE_64,
                                    height: DimensionConstant.SIZE_64,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: ColorConstant.C7C7CC,
                                        width: DimensionConstant.SIZE_1_POINT_5,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(
                                      DimensionConstant.SIZE_4,
                                    ),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        currentUser.storieAlbums[index].stories
                                            .first.storyImagePath,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: DimensionConstant.SIZE_3,
                                  ),
                                  Text(
                                    currentUser.storieAlbums[index].albumName,
                                  ),
                                ],
                              );
                      },
                      itemCount: currentUser.storieAlbums.length,
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
                controller: tabController,
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
                  controller: tabController,
                  children: <Widget>[
                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: currentUser.posts
                          .map(
                            (Post e) => CachedNetworkImage(
                              imageUrl: e.imagesPath.first,
                              fit: BoxFit.cover,
                              placeholder: (BuildContext context, String url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (BuildContext context, String url,
                                      Object error,) =>
                                  const Icon(Icons.error),
                            ),
                          )
                          .toList(),
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
        ),
      ),
    );
  }
}
