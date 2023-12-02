import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/theme.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/style.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class CommentHeading extends StatefulWidget {
  const CommentHeading({Key? key}) : super(key: key);

  @override
  _CommentHeadingState createState() => _CommentHeadingState();
}

class _CommentHeadingState extends State<CommentHeading> {
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
        const SizedBox(height: Spacing.sm),
        if (_isEditing) buildCommentInput(),
        const SizedBox(height: Spacing.md),
      ],
    );
  }

  Widget buildCommentInput() {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Write your comment...',
                contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0), // Adjust the radius as needed
                ),
              ),
            ),
          ),
          const SizedBox(width: Spacing.sm),
          IconButton(onPressed: () {}, icon: const Icon(FeatherIcons.send)),
        ],
      ),
    );
  }
}
