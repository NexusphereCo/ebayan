import 'dart:math';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/controller/anct_controller.dart';
import 'package:ebayan/data/viewmodel/comment_view_model.dart';
import 'package:ebayan/presentation/dashboard/announcements/widgets/comment_heading.dart';
import 'package:ebayan/presentation/dashboard/announcements/widgets/comments_list.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:flutter/material.dart';

class CommentSection extends StatelessWidget {
  final AnnouncementController _announcementController = AnnouncementController();
  final String annId;

  CommentSection({super.key, required this.annId});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // Allow items to overflow the stack
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            color: Colors.white,
          ),
          height: 500,
          child: FutureBuilder<List<CommentViewModel>>(
            future: _announcementController.fetchComments(annId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Return a loading indicator or placeholder
                return EBLoadingScreen();
              } else if (snapshot.hasError) {
                // Handle the error
                return SnackBar(content: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                // Handle the case when there is no data
                return Text('No comments available.');
              } else {
                final List<CommentViewModel> comments = snapshot.data!; // Build your ListView with the data
                return ListView(
                  padding: const EdgeInsets.all(Global.paddingBody),
                  children: [
                    Column(
                      children: [
                        commentHeading(),
                        buildComments(comments: comments),
                      ],
                    ),
                  ],
                );
              }
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
    );
  }
}
