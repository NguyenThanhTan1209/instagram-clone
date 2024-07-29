import 'package:flutter/material.dart';

import '../../utils/dimension_constant.dart';

class DrawerListItem extends StatelessWidget {
  const DrawerListItem({
    super.key,
    required this.iconPath,
    required this.title,
  });

  final String iconPath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        iconPath,
        width: DimensionConstant.SIZE_23_POINT_5,
        height: DimensionConstant.SIZE_23_POINT_5,
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontSize: DimensionConstant.SIZE_15),
      ),
    );
  }
}
