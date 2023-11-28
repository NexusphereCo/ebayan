import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/data/model/announcement_model.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:flutter/material.dart';

//turn into Widget
class AnnouncementCard extends StatelessWidget {
  final AnnouncementModel announcement;

  const AnnouncementCard({
    Key? key,
    required this.announcement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110,
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: EBColor.primary.shade200,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 10, // Adjust the width of the vertical bar as needed
                decoration: BoxDecoration(
                  color: EBColor.dullGreen[600]!.withOpacity(0.5), // Adjust the color of the vertical bar as needed
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
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
                        EBTypography.small(text: announcement.formattedTime, color: EBColor.dark, fontWeight: EBFontWeight.regular),
                      ],
                    ),
                  ),
                  const SizedBox(width: Spacing.lg),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EBButton(
                        onPressed: () {
                          Navigator.of(context).push(createRoute(route: Routes.announcement, args: announcement.id.toString()));
                        },
                        text: 'View',
                        theme: EBButtonTheme.primary,
                        size: EBButtonSize.sm,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
