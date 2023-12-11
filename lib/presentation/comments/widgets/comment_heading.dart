import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/controller/reaction_contoller.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/widgets/utils/fade_in.dart';
import 'package:ebayan/widgets/utils/rotate_widget.dart';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class CommentHeading extends StatefulWidget {
  final String annId;

  const CommentHeading({
    super.key,
    required this.annId,
  });

  @override
  State<CommentHeading> createState() => _CommentHeadingState();
}

class _CommentHeadingState extends State<CommentHeading> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ReactionController reactionController = ReactionController();
  final TextEditingController textController = TextEditingController();
  bool isEditing = false;

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  Future<void> postComment() async {
    bool isFormValid = formKey.currentState?.validate() == true;
    if (isFormValid) {
      try {
        await reactionController.createComment(widget.annId, textController.text);
        textController.clear();
        toggleEditing();
      } catch (e) {
        throw 'An error occurred while creating the comment.';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            EBTypography.h4(text: 'Comments'),
            Row(
              children: [
                const SizedBox(width: 3),
                StatefulBuilder(
                  builder: (context, setState) {
                    return TextButton(
                      onPressed: () => toggleEditing(),
                      child: Row(
                        children: [
                          EBTypography.text(
                            text: (isEditing) ? 'Discard' : 'Post a comment',
                            color: (isEditing) ? EBColor.red : EBColor.green,
                          ),
                          const SizedBox(width: Spacing.sm),
                          Icon(
                            FeatherIcons.feather,
                            color: (isEditing) ? EBColor.red : EBColor.green,
                            size: EBFontSize.normal,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        if (isEditing) buildCommentInput(),
      ],
    );
  }

  Widget buildCommentInput() {
    return FadeIn(
      child: Form(
        key: formKey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: textController,
                decoration: InputDecoration(
                  hintText: 'Write your comment...',
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: EBColor.dark)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: EBColor.primary)),
                  hintStyle: const TextStyle(fontSize: EBFontSize.normal),
                ),
                validator: (value) {
                  value = value?.trim();
                  if (value == null || value.isEmpty) return Validation.missingField;
                  return null;
                },
              ),
            ),
            RotateWidget(
              degree: 45,
              child: IconButton(
                onPressed: () => postComment(),
                icon: Icon(FeatherIcons.send, color: EBColor.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
