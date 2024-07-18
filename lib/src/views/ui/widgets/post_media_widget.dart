import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../business_logic/models/post.dart';
import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';

class PostMediaWidget extends StatelessWidget {
  const PostMediaWidget({
    super.key,
    required this.post,
    required this.screenWith,
    required this.postIndex,
  });

  final Post post;
  final double screenWith;
  final ValueNotifier<int> postIndex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CarouselSlider.builder(
          itemCount: post.images.length,
          itemBuilder: (
            BuildContext context,
            int index,
            int realIndex,
          ) {
            final String imageUrl = post.images[index];
            return Image.network(
              imageUrl,
              fit: BoxFit.cover,
            );
          },
          options: CarouselOptions(
            height: screenWith,
            viewportFraction: 1,
            onPageChanged: (
              int index,
              CarouselPageChangedReason reason,
            ) {
              postIndex.value = index + 1;
            },
          ),
        ),
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
              valueListenable: postIndex,
              builder: (
                BuildContext context,
                int value,
                Widget? child,
              ) {
                return Text(
                  '$value/${post.images.length}',
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
