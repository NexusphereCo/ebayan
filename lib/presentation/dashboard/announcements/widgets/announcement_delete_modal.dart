import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/anct_controller.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:flutter/material.dart';

class DeleteAnnouncement extends StatelessWidget {
  final String annId;
  final AnnouncementController announcementController = AnnouncementController();

  DeleteAnnouncement({super.key, required this.annId});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: EBColor.light,
        borderRadius: BorderRadius.circular(EBBorderRadius.lg),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 30,
            color: EBColor.green[600]!.withOpacity(0.25),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(Global.paddingBody),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            EBTypography.h3(text: 'Delete Announcement'),
            const SizedBox(height: Spacing.xs),
            EBTypography.text(
              text: 'Are  you sure you want to delete this announcement? \n\nThis action cannot be undone.',
              muted: true,
            ),
            const SizedBox(height: Spacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: EBTypography.text(text: 'Cancel', color: EBColor.red),
                ),
                const SizedBox(width: Spacing.md),
                EBButton(
                  onPressed: () async {
                    await announcementController.deleteAnnouncement(annId);

                    if (context.mounted) {
                      Navigator.of(context).popUntil(ModalRoute.withName(Routes.announcements));
                    }
                  },
                  text: 'Delete',
                  theme: EBButtonTheme.primaryOutlined,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
