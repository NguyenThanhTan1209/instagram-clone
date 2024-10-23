import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../business_logic/models/post.dart';
import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';
import 'media_item_widget.dart';

class PostMediaWidget extends StatefulWidget {
  const PostMediaWidget({
    super.key,
    required this.post,
    required this.postIndex,
  });

  final Post post;
  final ValueNotifier<int> postIndex;

  @override
  State<PostMediaWidget> createState() => _PostMediaWidgetState();
}

class _PostMediaWidgetState extends State<PostMediaWidget> {
  @override
  Widget build(BuildContext context) {
    final double screenWith = MediaQuery.sizeOf(context).width;

    return Stack(
      children: <Widget>[
        if (widget.post.media.length == 1)
          MediaItemWidget(
            mediaUrl: widget.post.media.first,
            isShowControls: true,
          )
        else
          CarouselSlider.builder(
            itemCount: widget.post.media.length,
            itemBuilder: (
              BuildContext context,
              int index,
              int realIndex,
            ) {
              final String imageUrl = widget.post.media[index];
              return MediaItemWidget(
                mediaUrl: imageUrl,
                isShowControls: true,
              );
            },
            options: CarouselOptions(
              height: screenWith,
              viewportFraction: 1,
              onPageChanged: (
                int index,
                CarouselPageChangedReason reason,
              ) {
                widget.postIndex.value = index + 1;
              },
            ),
          ),
        if (widget.post.media.length > 1)
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.all(
                DimensionConstant.SIZE_14,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: DimensionConstant.SIZE_6,
                horizontal: DimensionConstant.SIZE_8,
              ),
              decoration: BoxDecoration(
                color: ColorConstant.FF121212.withOpacity(
                  DimensionConstant.SIZE_0_POINT_7,
                ),
                borderRadius: BorderRadius.circular(
                  DimensionConstant.SIZE_13,
                ),
              ),
              child: ValueListenableBuilder<int>(
                valueListenable: widget.postIndex,
                builder: (
                  BuildContext context,
                  int value,
                  Widget? child,
                ) {
                  return Text(
                    '$value/${widget.post.media.length}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: DimensionConstant.SIZE_12,
                          color: ColorConstant.WHITE,
                        ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
