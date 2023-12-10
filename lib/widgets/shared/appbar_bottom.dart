import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/icons.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:flutter/material.dart';

class EBAppBarBottom extends StatelessWidget {
  final int activeIndex;

  const EBAppBarBottom({
    super.key,
    required this.activeIndex,
  });

  Widget buildContents(BuildContext context) {
    double iconSize = 20.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkResponse(
          onTap: () {
            if (ModalRoute.of(context)?.settings.name != Routes.dashboard) {
              Navigator.of(context).push(createRoute(route: Routes.dashboard));
            }
          },
          child: GestureDetector(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  (activeIndex == 1) ? EBIcons.homeSolid : EBIcons.home,
                  size: iconSize + 3,
                  color: (activeIndex == 1) ? EBColor.primary : EBColor.dark.withOpacity(0.5),
                ),
                const SizedBox(height: Spacing.sm),
                EBTypography.small(
                  text: 'Sphere',
                  color: (activeIndex == 1) ? EBColor.primary : EBColor.dark.withOpacity(0.5),
                  muted: (activeIndex == 1) ? false : true,
                ),
              ],
            ),
          ),
        ),
        InkResponse(
          onTap: () {
            if (ModalRoute.of(context)?.settings.name != Routes.people) {
              Navigator.of(context).push(createRoute(route: Routes.people));
            }
          },
          child: GestureDetector(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  (activeIndex == 2) ? EBIcons.usersSolid : EBIcons.users,
                  size: iconSize + 3,
                  color: (activeIndex == 2) ? EBColor.primary : EBColor.dark.withOpacity(0.5),
                ),
                const SizedBox(height: Spacing.sm),
                EBTypography.small(
                  text: 'People',
                  color: (activeIndex == 2) ? EBColor.primary : EBColor.dark.withOpacity(0.5),
                  muted: (activeIndex == 2) ? false : true,
                ),
              ],
            ),
          ),
        ),
        InkResponse(
          onTap: () {
            if (ModalRoute.of(context)?.settings.name != Routes.savedAnnouncement) {
              Navigator.of(context).push(createRoute(route: Routes.savedAnnouncement));
            }
          },
          child: GestureDetector(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  (activeIndex == 3) ? EBIcons.bookmarkSolid : EBIcons.bookmark,
                  size: iconSize + 3,
                  color: (activeIndex == 3) ? EBColor.primary : EBColor.dark.withOpacity(0.5),
                ),
                const SizedBox(height: Spacing.sm),
                EBTypography.small(
                  text: 'Saved',
                  color: (activeIndex == 3) ? EBColor.primary : EBColor.dark.withOpacity(0.5),
                  muted: (activeIndex == 3) ? false : true,
                ),
              ],
            ),
          ),
        ),
        InkResponse(
          onTap: () {
            if (ModalRoute.of(context)?.settings.name != Routes.accountInfo) {
              Navigator.of(context).push(createRoute(route: Routes.accountInfo));
            }
          },
          child: GestureDetector(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  (activeIndex == 4) ? EBIcons.settingsSolid : EBIcons.settings,
                  size: iconSize + 3,
                  color: (activeIndex == 4) ? EBColor.primary : EBColor.dark.withOpacity(0.5),
                ),
                const SizedBox(height: Spacing.sm),
                EBTypography.small(
                  text: 'Account',
                  color: (activeIndex == 4) ? EBColor.primary : EBColor.dark.withOpacity(0.5),
                  muted: (activeIndex == 4) ? false : true,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      color: Colors.white,
      child: buildContents(context),
    );
  }
}
