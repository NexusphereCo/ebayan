import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/data/viewmodel/comment_view_model.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/utils/fade_in.dart';
import 'package:flutter/material.dart';

Widget buildComments({required List<CommentViewModel> comments}) {
  final UserController _userController = UserController();
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 190,
          child: FadeIn(child: _buildListofComments(comments)),
        ),
      ],
    ),
  );
}

ListView _buildListofComments(List<CommentViewModel> comments) => ListView.builder(
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EBTypography.h4(text: comment.userId, fontWeight: EBFontWeight.semiBold),
            EBTypography.label(text: comment.text, maxLines: 3, fontWeight: EBFontWeight.regular),
            const SizedBox(height: Spacing.sm),
          ],
        );
      },
    );
