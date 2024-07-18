import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../business_logic/models/post.dart';
import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';
import '../../utils/path_constant.dart';

class PostFooterWidget extends StatelessWidget {
  const PostFooterWidget({
    super.key,
    required this.postIndex,
    required this.post,
  });

  final ValueNotifier<int> postIndex;
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DimensionConstant.SIZE_15,
        vertical: DimensionConstant.SIZE_10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    PathConstant.LIKE_ICON_PATH,
                    width: DimensionConstant.SIZE_26,
                    height: DimensionConstant.SIZE_26,
                  ),
                  const SizedBox(
                    width: DimensionConstant.SIZE_14,
                  ),
                  Image.asset(
                    PathConstant.COMMENT_ICON_PATH,
                    width: DimensionConstant.SIZE_26,
                    height: DimensionConstant.SIZE_26,
                  ),
                  const SizedBox(
                    width: DimensionConstant.SIZE_14,
                  ),
                  Image.asset(
                    PathConstant.SHARE_ICON_PATH,
                    width: DimensionConstant.SIZE_26,
                    height: DimensionConstant.SIZE_26,
                  ),
                ],
              ),
              const Spacer(),
              ValueListenableBuilder<int>(
                valueListenable: postIndex,
                builder: (
                  BuildContext context,
                  int value,
                  Widget? child,
                ) {
                  return SmoothPageIndicator(
                    effect: SlideEffect(
                      dotWidth: DimensionConstant.SIZE_6,
                      spacing: DimensionConstant.SIZE_4,
                      dotHeight: DimensionConstant.SIZE_6,
                      activeDotColor:
                          ColorConstant.FF3897F0,
                      dotColor:
                          ColorConstant.BLACK.withOpacity(
                        DimensionConstant.SIZE_0_POINT_15,
                      ),
                    ),
                    controller: PageController(
                      initialPage: value-1,
                    ),
                    count: post.images.length,
                  );
                },
              ),
              const Spacer(),
              Image.asset(
                PathConstant.SAVE_ICON_PATH,
                width: DimensionConstant.SIZE_26,
                height: DimensionConstant.SIZE_26,
              ),
            ],
          ),
          const SizedBox(
            height: DimensionConstant.SIZE_12,
          ),
          Row(
            children: <Widget>[
              const SizedBox(
                width: DimensionConstant.SIZE_17,
                height: DimensionConstant.SIZE_17,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://cdn-images.vtv.vn/zoom/640_400/562122370168008704/2024/1/10/photo1704856988808-17048569890141275762870.jpg',
                  ),
                ),
              ),
              const SizedBox(
                width: DimensionConstant.SIZE_6,
              ),
              RichText(
                text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                        fontSize: DimensionConstant.SIZE_13,
                      ),
                  children: <InlineSpan>[
                    const TextSpan(text: 'Liked by '),
                    TextSpan(
                      text: 'someone_user ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(
                            fontSize:
                                DimensionConstant.SIZE_13,
                          ),
                    ),
                    const TextSpan(text: 'and '),
                    TextSpan(
                      text: '520,000 others',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(
                            fontSize:
                                DimensionConstant.SIZE_13,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: DimensionConstant.SIZE_5,
          ),
          RichText(
            text: TextSpan(
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(
                    fontSize: DimensionConstant.SIZE_13,
                  ),
              children: <InlineSpan>[
                TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(
                        fontSize: DimensionConstant.SIZE_13,
                      ),
                  text: 'author_newc ',
                ),
                const TextSpan(
                  text:
                      'Ex fuga accusantium velit tempore est sit praesentium.',
                ),
              ],
            ),
          ),
          const SizedBox(
            height: DimensionConstant.SIZE_5,
          ),
          Text(
            'See all 500 comments',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(
                  fontSize: DimensionConstant.SIZE_13,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(
            height: DimensionConstant.SIZE_5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(
                          fontSize:
                              DimensionConstant.SIZE_13,
                        ),
                    children: <InlineSpan>[
                      TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                              fontSize:
                                  DimensionConstant.SIZE_13,
                            ),
                        text: 'comment_user ',
                      ),
                      const TextSpan(
                        text:
                            'Ex fuga accusantium velit tempore est sit praesentium.',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: DimensionConstant.SIZE_15,
              ),
              const Icon(
                Icons.favorite_outline,
                size: DimensionConstant.SIZE_13,
              ),
            ],
          ),
          const SizedBox(
            height: DimensionConstant.SIZE_5,
          ),
          Row(
            children: <Widget>[
              const SizedBox(
                width: DimensionConstant.SIZE_28,
                height: DimensionConstant.SIZE_28,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Gareth_Bale_2015_%281%29.jpg/573px-Gareth_Bale_2015_%281%29.jpg',
                  ),
                ),
              ),
              const SizedBox(
                width: DimensionConstant.SIZE_9,
              ),
              Text(
                'Add comment...',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(
                      fontSize: DimensionConstant.SIZE_12,
                      color: ColorConstant.FF999999,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
