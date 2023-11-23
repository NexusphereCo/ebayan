import 'dart:math';

import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/style.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class CommentSection extends StatelessWidget {
  const CommentSection({Key? key}) : super(key: key);

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
          child: Padding(
            padding: const EdgeInsets.all(Global.paddingBody),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: Spacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    EBTypography.h4(text: 'Comments'),
                    Row(
                      children: [
                        Icon(
                          FeatherIcons.feather,
                          size: EBFontSize.normal,
                          color: EBColor.green,
                        ),
                        const SizedBox(width: 3),
                        EBTypography.text(
                          text: 'Post a comment',
                          color: EBColor.green,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: Spacing.md),
                // Add your comment section content here
                // For example, a ListView.builder for displaying comments
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5, // Replace with your actual comment count
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Comment $index'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -20, // Adjust this value to move the button up
          right: 0,
          left: 0,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(); // Close the bottom sheet
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: EBColor.green, // Adjust the color as needed
              ),
              child: Center(
                child: Transform.rotate(
                  angle: 90 * pi / 180,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: EBColor.light, // Adjust the color as needed
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
