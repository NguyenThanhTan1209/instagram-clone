import 'package:flutter/material.dart';

import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';
import '../../utils/string_constant.dart';

class SignInFooterWidget extends StatelessWidget {
  const SignInFooterWidget({
    super.key,
    required this.label,
    required this.actionLabel,
    required this.actionColor,
    required this.onPressed,
  });

  final String label;
  final String actionLabel;
  final Color actionColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstant.WHITE,
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: const Offset(
              DimensionConstant.SIZE_0,
              DimensionConstant.SIZE_NEGATIVE_0_POINT_33,
            ),
            color: ColorConstant.FF3C3C43.withOpacity(
              DimensionConstant.SIZE_0_POINT_29,
            ),
          ),
        ],
      ),
      height: DimensionConstant.SIZE_84,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: DimensionConstant.SIZE_18,
          ),
          RichText(
            text: TextSpan(
              children: <InlineSpan>[
                WidgetSpan(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: ColorConstant.BLACK.withOpacity(
                            DimensionConstant.SIZE_0_POINT_40,
                          ),
                          fontSize: DimensionConstant.SIZE_12,
                        ),
                  ),
                ),
                WidgetSpan(
                  child: InkWell(
                    onTap: onPressed,
                    child: Text(
                      actionLabel,
                      style: label.isNotEmpty
                          ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: actionColor,
                                fontSize: DimensionConstant.SIZE_12,
                              )
                          : Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: actionColor,
                                fontSize: DimensionConstant.SIZE_12,
                              ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
