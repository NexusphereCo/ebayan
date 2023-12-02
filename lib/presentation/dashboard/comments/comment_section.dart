import 'dart:math';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/controller/anct_controller.dart';
import 'package:ebayan/data/viewmodel/comment_view_model.dart';
import 'package:ebayan/presentation/dashboard/comments/widgets/comment_handling.dart';
import 'package:ebayan/presentation/dashboard/comments/widgets/comment_heading.dart';
import 'package:ebayan/presentation/dashboard/comments/widgets/comments_list.dart';
import 'package:ebayan/utils/style.dart';
import 'package:flutter/material.dart';

class CommentSection extends StatefulWidget {
  final String annId;

  const CommentSection({Key? key, required this.annId}) : super(key: key);

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final AnnouncementController _announcementController = AnnouncementController();
  bool isCommentInputVisible = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: List<Widget>.from([
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            color: Colors.white,
          ),
          height: 500,
          child: FutureBuilder<List<CommentViewModel>>(
            future: _announcementController.fetchComments(widget.annId),
            builder: (context, snapshot) {
              final List<CommentViewModel> comments = snapshot.data ?? [];

              return ListView(
                padding: const EdgeInsets.all(Global.paddingBody),
                children: [
                  const CommentHeading(),
                  if (snapshot.connectionState == ConnectionState.waiting) buildLoadingIndicator(),
                  if (comments == null || comments.isEmpty) buildNoComments(),
                  if (comments.isNotEmpty) buildComments(comments: comments),
                ],
              );
            },
          ),
        ),
        Positioned(
          top: -20,
          right: 0,
          left: 0,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: EBColor.primary,
              ),
              child: Center(
                child: Transform.rotate(
                  angle: 90 * pi / 180,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: EBColor.light,
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
