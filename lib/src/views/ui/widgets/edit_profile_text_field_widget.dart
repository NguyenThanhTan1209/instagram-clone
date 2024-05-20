import 'package:flutter/material.dart';

import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';

class EditProfileTextFieldWidget extends StatelessWidget {
  const EditProfileTextFieldWidget({
    super.key,
    required this.label,
    required this.placeholder,
    required this.controller,
    this.isExpand = false,
  });

  final String label;
  final String placeholder;
  final TextEditingController controller;
  final bool isExpand;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: DimensionConstant.SIZE_96,
          child: Text(
            label,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: DimensionConstant.SIZE_15),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              left: DimensionConstant.SIZE_16,
            ),
            child: TextField(
              controller: controller,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: DimensionConstant.SIZE_16,
                  ),
              maxLines: isExpand ? 2 : 1,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: DimensionConstant.SIZE_15,
                ),
                hintText: placeholder,
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ColorConstant.C5C5C7,
                    ),
                border: isExpand
                    ? InputBorder.none
                    : const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorConstant.C5C5C7,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
