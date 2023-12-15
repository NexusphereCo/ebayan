import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/data/viewmodel/comment_view_model.dart';
import 'package:feather_icons/feather_icons.dart';

import 'package:flutter/material.dart';

class CommentsList extends StatelessWidget {
  final List<CommentViewModel> comments;

  const CommentsList({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final comment = comments[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Global.paddingBody),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(FeatherIcons.user, color: EBColor.dark),
                const SizedBox(width: Spacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EBTypography.h4(text: comment.username, fontWeight: EBFontWeight.semiBold),
                      EBTypography.label(text: comment.text, maxLines: 3, fontWeight: EBFontWeight.regular),
                      const SizedBox(height: Spacing.md),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        childCount: comments.length,
      ),
    );
  }
}
