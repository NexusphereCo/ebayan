import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/data/viewmodel/announcement_view_model.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/widgets/utils/fade_in.dart';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildLatestAnnouncements({
  required List<AnnouncementViewModel> announcements,
}) {
  return (announcements.isNotEmpty)
      ? Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(EBBorderRadius.lg),
                bottomLeft: Radius.circular(EBBorderRadius.lg),
              ),
              color: EBColor.dullGreen[50],
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    Asset.recentAnnCircle,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20, 0, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EBTypography.h3(text: 'Recent Announcement'),
                      EBTypography.text(text: 'Here\'s your recent announcements from your barangay.'),
                      SizedBox(
                        height: 190,
                        child: FadeIn(child: _buildListOfAnnouncements(announcements)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      : _buildEmptyAnnouncements();
}

Widget _buildListOfAnnouncements(List<AnnouncementViewModel> announcements) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: announcements.length,
    itemBuilder: (context, index) => Container(
      width: 300,
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(EBBorderRadius.lg),
        color: EBColor.light,
        boxShadow: [
          BoxShadow(
            color: EBColor.dullGreen[500]!.withOpacity(0.35),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                Asset.recentAnnWave,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.md, vertical: Spacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: EBBorderRadius.md, vertical: EBBorderRadius.xs),
                        decoration: BoxDecoration(
                          color: EBColor.green,
                          borderRadius: const BorderRadius.all(Radius.circular(EBBorderRadius.lg)),
                        ),
                        child: EBTypography.label(text: 'Important', color: EBColor.light),
                      ),
                      EBTypography.small(text: DateFormat('MMM d').format(announcements[index].timeCreated)),
                    ],
                  ),
                  const SizedBox(height: Spacing.md),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(FeatherIcons.user, color: EBColor.dark),
                      const SizedBox(width: Spacing.sm),
                      EBTypography.h4(text: announcements[index].author),
                    ],
                  ),
                  const SizedBox(height: Spacing.md - 5),
                  EBTypography.text(
                    text: announcements[index].heading,
                    cutOverflow: true,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(createRoute(route: Routes.announcement, args: announcements[index].id.toString()));
                },
                icon: Icon(
                  FeatherIcons.arrowRight,
                  color: EBColor.light,
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget _buildEmptyAnnouncements() {
  return Container(
    margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(EBBorderRadius.lg),
          bottomLeft: Radius.circular(EBBorderRadius.lg),
        ),
        color: EBColor.dullGreen[50],
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(
              Asset.recentAnnEmpty,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20, 0, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EBTypography.h3(text: 'Recent Announcement'),
                EBTypography.text(text: 'There\'s currently no recent announcement from your barangay. \n\nCheck back later!'),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
