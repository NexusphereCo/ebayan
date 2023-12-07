import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/controller/cmnt_contoller.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/widgets/utils/fade_in.dart';
import 'package:ebayan/widgets/utils/rotate_widget.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class CommentHeading extends StatefulWidget {
  final String annId;
  final Function() onCommentAdded;

  const CommentHeading({
    super.key,
    required this.annId,
    required this.onCommentAdded,
  });

  @override
  State<CommentHeading> createState() => _CommentHeadingState();
}

class _CommentHeadingState extends State<CommentHeading> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CommentController _commentController = CommentController();
  final TextEditingController _textController = TextEditingController();
  bool _isEditing = false;

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
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
                TextButton(
                  onPressed: () => _toggleEditing(),
                  child: Row(
                    children: [
                      EBTypography.text(
                        text: (_isEditing) ? 'Discard' : 'Post a comment',
                        color: (_isEditing) ? EBColor.red : EBColor.green,
                      ),
                      const SizedBox(width: Spacing.sm),
                      Icon(
                        FeatherIcons.feather,
                        color: (_isEditing) ? EBColor.red : EBColor.green,
                        size: EBFontSize.normal,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        if (_isEditing) buildCommentInput(),
      ],
    );
  }

  Widget buildCommentInput() {
    return FadeIn(
      child: Form(
        key: _formKey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: _textController,
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
                onPressed: () async {
                  if (_formKey.currentState?.validate() == true) {
                    try {
                      await _commentController.createComment(widget.annId, _textController.text);
                      _textController.clear();
                      _toggleEditing();
                      widget.onCommentAdded();
                    } catch (e) {
                      throw 'An error occurred while creating the comment.';
                    }
                  }
                },
                icon: Icon(FeatherIcons.send, color: EBColor.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
