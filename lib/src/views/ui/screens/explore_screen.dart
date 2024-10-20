import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../../business_logic/models/post.dart';
import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';
import '../../utils/string_constant.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int totalOdd = 0;

    final List<Post> posts = <Post>[
      Post(
        postID: 'adsfsdf',
        userID: 'sdfadfsf',
        avatarPath: 'https://picsum.photos/500',
        userName: 'Virgie.Herman20',
        media: <String>['https://picsum.photos/500'],
        createdDate: '20-11-2024',
        likedUsers: <String>[],
        comments: <String>[],
      ),
      Post(
        postID: 'adsfsdf',
        userID: 'sdfadfsf',
        avatarPath: 'https://picsum.photos/500',
        userName: 'Sally.Douglas',
        media: <String>['https://picsum.photos/seed/picsum/200/300'],
        createdDate: '20-11-2024',
        likedUsers: <String>[],
        comments: <String>[],
      ),
      Post(
        postID: 'adsfsdf',
        userID: 'sdfadfsf',
        avatarPath: 'https://picsum.photos/500',
        userName: 'Jess.Von92',
        media: <String>['https://picsum.photos/500'],
        createdDate: '20-11-2024',
        likedUsers: <String>[],
        comments: <String>[],
      ),
      Post(
        postID: 'adsfsdf',
        userID: 'sdfadfsf',
        avatarPath: 'https://picsum.photos/500',
        userName: 'Athena69',
        media: <String>['https://picsum.photos/500'],
        createdDate: '20-11-2024',
        likedUsers: <String>[],
        comments: <String>[],
      ),
      Post(
        postID: 'adsfsdf',
        userID: 'sdfadfsf',
        avatarPath: 'https://picsum.photos/500',
        userName: 'Libby4',
        media: <String>['https://picsum.photos/500'],
        createdDate: '20-11-2024',
        likedUsers: <String>[],
        comments: <String>[],
      ),
      Post(
        postID: 'adsfsdf',
        userID: 'sdfadfsf',
        avatarPath: 'https://picsum.photos/500',
        userName: 'Annetta_Mayert',
        media: <String>['https://picsum.photos/500'],
        createdDate: '20-11-2024',
        likedUsers: <String>[],
        comments: <String>[],
      ),
      Post(
        postID: 'adsfsdf',
        userID: 'sdfadfsf',
        avatarPath: 'https://picsum.photos/500',
        userName: 'Florida41',
        media: <String>['https://picsum.photos/500'],
        createdDate: '20-11-2024',
        likedUsers: <String>[],
        comments: <String>[],
      ),
      Post(
        postID: 'adsfsdf',
        userID: 'sdfadfsf',
        avatarPath: 'https://picsum.photos/500',
        userName: 'Lea.OHara',
        media: <String>['https://picsum.photos/500'],
        createdDate: '20-11-2024',
        likedUsers: <String>[],
        comments: <String>[],
      ),
      Post(
        postID: 'adsfsdf',
        userID: 'sdfadfsf',
        avatarPath: 'https://picsum.photos/500',
        userName: 'Mckenzie58',
        media: <String>['https://picsum.photos/500'],
        createdDate: '20-11-2024',
        likedUsers: <String>[],
        comments: <String>[],
      ),
      Post(
        postID: 'adsfsdf',
        userID: 'sdfadfsf',
        avatarPath: 'https://picsum.photos/500',
        userName: 'Beatrice60',
        media: <String>['https://picsum.photos/500'],
        createdDate: '20-11-2024',
        likedUsers: <String>[],
        comments: <String>[],
      ),
      Post(
        postID: 'adsfsdf',
        userID: 'sdfadfsf',
        avatarPath: 'https://picsum.photos/500',
        userName: 'Darian36',
        media: <String>['https://picsum.photos/500'],
        createdDate: '20-11-2024',
        likedUsers: <String>[],
        comments: <String>[],
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              flexibleSpace: Column(
                children: <Widget>[
                  const SizedBox(
                    height: DimensionConstant.SIZE_4,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimensionConstant.SIZE_8,
                    ),
                    height: DimensionConstant.SIZE_36,
                    child: TextField(
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        hintStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: ColorConstant.FF3C3C43.withOpacity(
                                    DimensionConstant.SIZE_0_POINT_60,
                                  ),
                                ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: ColorConstant.FF3C3C43.withOpacity(
                            DimensionConstant.SIZE_0_POINT_60,
                          ),
                        ),
                        hintText: StringConstant.SEARCH_LABEL,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            DimensionConstant.SIZE_12,
                          ),
                          borderSide: BorderSide.none,
                        ),
                        // fillColor: ColorConstant.FF767680.withOpacity(
                        //   DimensionConstant.SIZE_0_POINT_12,
                        // ),
                        fillColor: ColorConstant.FF767680
                            .withOpacity(DimensionConstant.SIZE_0_POINT_12),
                        contentPadding: const EdgeInsets.only(
                          top: DimensionConstant.SIZE_6,
                          bottom: DimensionConstant.SIZE_8,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: DimensionConstant.SIZE_7,
                  ),
                ],
              ), //
            ),
            SliverList.list(
              children: <Widget>[
                StaggeredGridView.countBuilder(
                  staggeredTileBuilder: (int index) {
                    if (index.isEven) {
                      return const StaggeredTile.count(1, 1);
                    }
                    if (index.isOdd) {
                      totalOdd += 1;
                    }
                    if (totalOdd == 3) {
                      totalOdd = 0;
                      return const StaggeredTile.count(1, 1);
                    }
                    return const StaggeredTile.count(2, 2);
                  },
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GridTile(
                      child: CachedNetworkImage(
                        imageUrl: posts.elementAt(index).media.first,
                      ),
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
