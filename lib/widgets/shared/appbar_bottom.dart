import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/icons.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';

class EBAppBarBottom extends StatelessWidget {
  final int activeIndex;

  const EBAppBarBottom({
    super.key,
    required this.activeIndex,
  });

  Widget buildContents(BuildContext context) {
    double paddingY = 15.0;
    double iconSize = 20.0;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: paddingY),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkResponse(
            onTap: () {
              Navigator.of(context).pushReplacement(createRoute(route: '/dashboard'));
            },
            child: GestureDetector(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                spacing: 10.0,
                children: [
                  Icon(
                    EBIcons.home,
                    size: iconSize + 3,
                    color: (activeIndex == 1) ? EBColor.primary : EBColor.dark.withOpacity(0.5),
                  ),
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
            onTap: () {},
            child: GestureDetector(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                spacing: 10.0,
                children: [
                  Icon(
                    FeatherIcons.users,
                    size: iconSize,
                    color: (activeIndex == 2) ? EBColor.primary : EBColor.dark.withOpacity(0.5),
                  ),
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
            onTap: () {},
            child: GestureDetector(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                spacing: 10.0,
                children: [
                  Icon(
                    FeatherIcons.bookmark,
                    size: iconSize,
                    color: (activeIndex == 3) ? EBColor.primary : EBColor.dark.withOpacity(0.5),
                  ),
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
              Navigator.of(context).pushReplacement(createRoute(route: '/account/info'));
            },
            child: GestureDetector(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                spacing: 10.0,
                children: [
                  Icon(
                    FeatherIcons.settings,
                    size: iconSize,
                    color: (activeIndex == 4) ? EBColor.primary : EBColor.dark.withOpacity(0.5),
                  ),
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
      ),
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
