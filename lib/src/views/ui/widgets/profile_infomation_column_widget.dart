import 'package:flutter/material.dart';

import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';

class ProfileInfoColumnWidget extends StatelessWidget {
  const ProfileInfoColumnWidget({
    super.key,
    required this.number,
    required this.label,
  });

  final int number;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          number.toString(),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: ColorConstant.FF262626,
                fontSize: DimensionConstant.SIZE_16,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ColorConstant.FF262626,
                fontSize: DimensionConstant.SIZE_13,
              ),
        ),
      ],
    );
  }
}
