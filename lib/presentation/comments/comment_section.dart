import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/controller/reaction_contoller.dart';
import 'package:ebayan/data/viewmodel/comment_view_model.dart';
import 'package:ebayan/presentation/comments/widgets/comment_handling.dart';
import 'package:ebayan/presentation/comments/widgets/comment_heading.dart';
import 'package:ebayan/presentation/comments/widgets/comments_list.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/utils/rotate_widget.dart';

import 'package:flutter/material.dart';

class CommentSection extends StatefulWidget {
  final String annId;

  const CommentSection({super.key, required this.annId});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final ReactionController reactionController = ReactionController();

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
            child: FutureBuilder(
              future: reactionController.fetchComments(widget.annId),
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
                      const SliverToBoxAdapter(
                        child: EBCircularLoadingIndicator(height: 300),
                      )
                    else if (comments.isEmpty)
                      SliverToBoxAdapter(child: buildNoComments())
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
                  child: RotateWidget(
                    degree: 90,
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
