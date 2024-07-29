import 'package:flutter/material.dart';

import '../../../business_logic/models/post.dart';
import '../../utils/dimension_constant.dart';

class PostTitleWidget extends StatelessWidget {
  const PostTitleWidget({
    super.key, required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: DimensionConstant.SIZE_11,
        horizontal: DimensionConstant.SIZE_10,
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: DimensionConstant.SIZE_32,
            height: DimensionConstant.SIZE_32,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                post.avatarPath,
              ),
            ),
          ),
          const SizedBox(
            width: DimensionConstant.SIZE_10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                post.userName,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: DimensionConstant.SIZE_13,
                    ),
              ),
              const SizedBox(
                height: DimensionConstant.SIZE_1,
              ),
              Text(
                'Tân Châu, An Giang',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: DimensionConstant.SIZE_11,
                    ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.more_vert_rounded),
        ],
      ),
    );
  }
}
