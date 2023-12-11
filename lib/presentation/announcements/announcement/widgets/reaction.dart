import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/reaction_contoller.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RenderReaction extends StatefulWidget {
  final String annId;
  const RenderReaction({
    super.key,
    required this.annId,
  });

  @override
  State<RenderReaction> createState() => _RenderReactionState();
}

class _RenderReactionState extends State<RenderReaction> {
  final ReactionController announcementController = ReactionController();

  bool isThumbsUp = false;
  bool isThumbsDown = false;

  void setReaction() async {
    // Implement your Firebase update logic here
    // You can use Firebase Firestore or Realtime Database to update the reaction
    // For example, you might update a document in the 'posts' collection with the reaction
    // Make sure to replace 'your_post_id' with the actual post ID
    // and adjust the logic based on your Firebase structure
    /// ```dart
    /// FirebaseFirestore.instance.collection('posts').doc('your_post_id').update({
    ///   'thumbsUp': thumbsUp,
    ///   'thumbsDown': !thumbsUp,
    /// });
    await announcementController.setReaction(widget.annId, isThumbsUp, isThumbsDown);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        EBTypography.text(text: 'What did you think about this post?', fontWeight: FontWeight.bold),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isThumbsUp = !isThumbsUp;
                    isThumbsDown = false;
                    setReaction();
                  });
                },
                splashColor: Colors.transparent,
                child: Ink(
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.sm, vertical: Spacing.md),
                  child: Row(
                    children: [
                      FaIcon(
                        (isThumbsUp) ? FontAwesomeIcons.solidThumbsUp : FontAwesomeIcons.thumbsUp,
                        size: EBFontSize.h3,
                        color: EBColor.primary,
                      ),
                      const SizedBox(width: Spacing.sm),
                      EBTypography.text(text: 'Like', color: EBColor.primary),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: Spacing.lg),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isThumbsDown = !isThumbsDown;
                    isThumbsUp = false;
                    setReaction();
                  });
                },
                splashColor: Colors.transparent,
                child: Ink(
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.sm, vertical: Spacing.md),
                  child: Row(
                    children: [
                      FaIcon(
                        (isThumbsDown) ? FontAwesomeIcons.solidThumbsDown : FontAwesomeIcons.thumbsDown,
                        size: EBFontSize.h3,
                        color: EBColor.primary,
                      ),
                      const SizedBox(width: Spacing.sm),
                      EBTypography.text(text: 'Dislike', color: EBColor.primary),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
