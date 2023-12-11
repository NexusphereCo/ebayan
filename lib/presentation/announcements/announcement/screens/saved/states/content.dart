import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/data/viewmodel/announcement_view_model.dart';
import 'package:ebayan/presentation/announcements/widgets/announcement_card.dart';
import 'package:ebayan/widgets/utils/fade_in.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RenderSavedAnnouncements extends StatelessWidget {
  final int index;

  const RenderSavedAnnouncements({
    super.key,
    required this.announcements,
    required this.index,
  });

  final List<AnnouncementViewModel> announcements;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (index == 0)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  EBTypography.h1(text: 'Announcement'),
                  const SizedBox(width: Spacing.sm),
                  FaIcon(
                    FontAwesomeIcons.solidBookmark,
                    size: 30,
                    color: EBColor.dark,
                  ),
                ],
              ),
              const SizedBox(height: Spacing.md),
            ],
          ),
        FadeIn(
          child: AnnouncementCard(announcement: announcements[index]),
        ),
      ],
    );
  }
}
