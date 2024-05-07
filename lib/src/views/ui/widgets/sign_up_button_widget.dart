import 'package:flutter/material.dart';

import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';

class SignUpButtonWidget extends StatelessWidget {
  const SignUpButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

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
      child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: DimensionConstant.SIZE_14,
                  color: ColorConstant.BLACK,
                ),
          ),
    );
  }
}
