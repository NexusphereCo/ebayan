import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/anct_controller.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:flutter/material.dart';

class DeleteAnnouncementBox extends StatelessWidget {
  final String annId;

  const DeleteAnnouncementBox({super.key, required this.annId});

  @override
  Widget build(BuildContext context) {
    final AnnouncementController _announcementController = AnnouncementController();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: 200,
        height: 170,
        padding: const EdgeInsets.all(Global.paddingBody),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          EBTypography.h4(text: 'Are  you sure you want to delete this announcement?', fontWeight: EBFontWeight.bold),
          EBTypography.small(text: 'This action cannot be undone,'),
          const SizedBox(height: Spacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              EBButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: 'Cancel',
                theme: EBButtonTheme.primaryOutlined,
              ),
              EBButton(
                onPressed: () async {
                  await _announcementController.deleteAnnouncement(annId);
                  Navigator.of(context).push(createRoute(route: Routes.announcements));
                },
                text: 'Delete',
                theme: EBButtonTheme.primary,
              ),
            ],
          )
        ]),
      ),
    );
  }
}
