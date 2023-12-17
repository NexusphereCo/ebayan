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

class _RenderReactionState extends State<RenderReaction> with TickerProviderStateMixin {
  late ReactionController announcementController;
  late AnimationController thumbsUpController;
  late AnimationController thumbsDownController;

  bool isThumbsUp = false;
  bool isThumbsDown = false;

  @override
  void initState() {
    super.initState();
    announcementController = ReactionController();
    thumbsUpController = createAnimationController();
    thumbsDownController = createAnimationController();

    setReactionStateToButtons();
  }

  AnimationController createAnimationController() {
    return AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
  }

  @override
  void dispose() {
    thumbsUpController.dispose();
    thumbsDownController.dispose();
    super.dispose();
  }

  void setReaction() async {
    await announcementController.setReaction(widget.annId, isThumbsUp, isThumbsDown);
  }

  Future<void> setReactionStateToButtons() async {
    var isLiked = await announcementController.fetchReaction(widget.annId);
    if (isLiked != null) {
      setState(() {
        isThumbsUp = isLiked;
        isThumbsDown = !isLiked;
      });
    }
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
            ScaleTransition(
              scale: Tween<double>(begin: 1.0, end: 0.7).animate(thumbsUpController),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    thumbsUpController.forward();
                    Future.delayed(const Duration(milliseconds: 100), () {
                      thumbsUpController.reverse();
                    });

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
            ),
            const SizedBox(width: Spacing.lg),
            ScaleTransition(
              scale: Tween<double>(begin: 1.0, end: 0.7).animate(thumbsDownController),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    thumbsDownController.forward();
                    Future.delayed(const Duration(milliseconds: 100), () {
                      thumbsDownController.reverse();
                    });

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
            ),
          ],
        ),
      ],
    );
  }
}
