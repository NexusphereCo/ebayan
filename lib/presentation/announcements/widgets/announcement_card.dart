import 'dart:ui';

import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/data/viewmodel/announcement_view_model.dart';
import 'package:ebayan/presentation/announcements/announcement/screens/saved/states/content.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:feather_icons/feather_icons.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

class AnnouncementCard extends StatelessWidget {
  final AnnouncementViewModel announcement;
  final int? index;
  final bool? dismissible;
  final RenderSavedAnnouncementsState? parent;
  final UserController _userController = UserController();

  AnnouncementCard({
    super.key,
    required this.announcement,
    this.dismissible,
    this.index,
    this.parent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(EBBorderRadius.md),
        child: Slidable(
          key: ValueKey(index),
          closeOnScroll: true,
          enabled: dismissible ?? false,
          endActionPane: ActionPane(
            motion: const BehindMotion(),
            dismissible: DismissiblePane(
              onDismissed: () async {
                await _userController.deleteSavedAnnouncement(announcement.id);
                parent!.refresh();
              },
            ),
            children: [
              SlidableAction(
                flex: 1,
                onPressed: (context) async {
                  await _userController.deleteSavedAnnouncement(announcement.id);
                  parent!.refresh();
                },
                backgroundColor: EBColor.red,
                foregroundColor: Colors.white,
                icon: FeatherIcons.trash,
                label: 'Delete',
                autoClose: true,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  createRoute(route: Routes.announcement, args: announcement.id.toString()),
                );
              },
              splashColor: EBColor.green[100],
              child: Ink(
                color: EBColor.primary[100],
                child: Stack(
                  children: [
                    buildBorderLeftAccent(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                      child: buildContents(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Positioned buildBorderLeftAccent() {
    return Positioned(
      left: 0,
      top: 0,
      bottom: 0,
      child: Container(
        width: 10,
        decoration: BoxDecoration(
          color: EBColor.dullGreen[600]!.withOpacity(0.5),
        ),
      ),
    );
  }

  Row buildContents(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EBTypography.h4(
                text: announcement.heading,
                color: EBColor.primary,
                fontWeight: FontWeight.bold,
                cutOverflow: true,
                maxLines: 3,
              ),
              EBTypography.small(
                text: announcement.formattedTime,
                color: EBColor.dark,
                fontWeight: EBFontWeight.regular,
              ),
            ],
          ),
        ),
        const SizedBox(width: Spacing.lg),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EBButton(
              onPressed: () {
                Navigator.of(context).push(
                  createRoute(route: Routes.announcement, args: announcement.id.toString()),
                );
              },
              text: 'View',
              theme: EBButtonTheme.primary,
              size: EBButtonSize.sm,
            ),
          ],
        ),
      ],
    );
  }
}
