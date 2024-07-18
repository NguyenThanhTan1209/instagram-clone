import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';

class StoryItemWidget extends StatelessWidget {
  const StoryItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: DimensionConstant.SIZE_62,
          height: DimensionConstant.SIZE_62,
          padding:
              const EdgeInsets.all(DimensionConstant.SIZE_2),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            border: GradientBoxBorder(
              width: DimensionConstant.SIZE_2,
              gradient: LinearGradient(
                colors: <Color>[
                  ColorConstant.FBAA47,
                  ColorConstant.D91A46,
                  ColorConstant.A60F93,
                ],
              ),
            ),
          ),
          child: const CircleAvatar(
            backgroundImage: NetworkImage(
              'https://photo.znews.vn/w660/Uploaded/ywfrd/2022_11_27/316113173_6813724855340043_6024556815075164425_n.jpg',
            ),
          ),
        ),
        const SizedBox(
          height: DimensionConstant.SIZE_4,
        ),
        Text(
          'user_name',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
