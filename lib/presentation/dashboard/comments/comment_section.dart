import 'dart:math';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/controller/cmnt_contoller.dart';
import 'package:ebayan/data/viewmodel/comment_view_model.dart';
import 'package:ebayan/presentation/dashboard/comments/widgets/comment_handling.dart';
import 'package:ebayan/presentation/dashboard/comments/widgets/comment_heading.dart';
import 'package:ebayan/presentation/dashboard/comments/widgets/comments_list.dart';
import 'package:ebayan/utils/style.dart';
import 'package:flutter/material.dart';

class CommentSection extends StatefulWidget {
  final String annId;

  const CommentSection({super.key, required this.annId});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final CommentController _commentController = CommentController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets * 0.3,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              color: Colors.white,
            ),
            height: 400,
            child: FutureBuilder<List<CommentViewModel>>(
              future: _commentController.fetchComments(widget.annId),
              builder: (context, snapshot) {
                final List<CommentViewModel> comments = snapshot.data ?? [];

                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(Global.paddingBody),
                        child: CommentHeading(
                          annId: widget.annId,
                          onCommentAdded: () {
                            // Refresh the comments when a new comment is added
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    if (snapshot.connectionState == ConnectionState.waiting)
                      SliverToBoxAdapter(
                        child: buildLoadingIndicator(),
                      )
                    else if (comments.isEmpty)
                      SliverToBoxAdapter(
                        child: buildNoComments(),
                      )
                    else
                      CommentsList(comments: comments),
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
        ],
      ),
    );
  }
}
