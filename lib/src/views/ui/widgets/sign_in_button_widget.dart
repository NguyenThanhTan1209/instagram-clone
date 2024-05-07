import 'package:flutter/material.dart';

import '../../utils/dimension_constant.dart';

class SignInButtonWidget extends StatelessWidget {
  const SignInButtonWidget({
    super.key,
    required this.onPressed,
    required this.iconPath,
    required this.title,
    required this.backgroundColor,
    required this.textColor,
  });

  final VoidCallback onPressed;
  final String iconPath;
  final String title;
  final Color textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(
          DimensionConstant.SIZE_307,
          DimensionConstant.SIZE_44,
        ),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DimensionConstant.SIZE_16),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            iconPath,
            width: DimensionConstant.SIZE_20,
            height: DimensionConstant.SIZE_20,
          ),
          const SizedBox(
            width: DimensionConstant.SIZE_15,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: DimensionConstant.SIZE_14,
                  color: textColor,
                ),
          ),
        ],
      ),
    );
  }
}
