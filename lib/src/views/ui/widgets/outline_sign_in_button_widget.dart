import 'package:flutter/material.dart';

import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';

class OutlineSignInButtonWidget extends StatelessWidget {
  const OutlineSignInButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
    required this.iconPath,
  });

  final VoidCallback onPressed;
  final String title;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(
          DimensionConstant.SIZE_307,
          DimensionConstant.SIZE_44,
        ),
        backgroundColor: ColorConstant.WHITE,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DimensionConstant.SIZE_16),
        ),
        side: BorderSide(
          color: ColorConstant.FF3C3C43
              .withOpacity(DimensionConstant.SIZE_0_POINT_18),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Visibility(
            visible: iconPath.isNotEmpty,
            child: Image.asset(iconPath),
          ),
          SizedBox(
            width: iconPath.isEmpty
                ? DimensionConstant.SIZE_0
                : DimensionConstant.SIZE_15,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: DimensionConstant.SIZE_14,
                  color: ColorConstant.BLACK,
                ),
          ),
        ],
      ),
    );
  }
}
