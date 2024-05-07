import 'package:flutter/material.dart';

import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';
import '../../utils/string_constant.dart';

class HorizontalOrLineWidget extends StatelessWidget {
  const HorizontalOrLineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DimensionConstant.SIZE_16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Divider(
              color: ColorConstant.BLACK
                  .withOpacity(DimensionConstant.SIZE_0_POINT_2),
            ),
          ),
          const SizedBox(width: DimensionConstant.SIZE_30_POINT_5),
          Text(
            StringConstant.OR_LABEL,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: DimensionConstant.SIZE_12,
                  color: ColorConstant.BLACK
                      .withOpacity(DimensionConstant.SIZE_0_POINT_40),
                ),
          ),
          const SizedBox(width: DimensionConstant.SIZE_30_POINT_5),
          Expanded(
            child: Divider(
              color: ColorConstant.BLACK
                  .withOpacity(DimensionConstant.SIZE_0_POINT_2),
            ),
          ),
        ],
      ),
    );
  }
}
