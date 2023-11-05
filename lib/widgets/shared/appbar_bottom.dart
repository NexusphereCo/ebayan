import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/icons.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';

class EBAppBarBottom extends StatelessWidget {
  const EBAppBarBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      color: Colors.white,
      child: EBAppBarBottomContents(),
    );
  }
}

class EBAppBarBottomContents extends StatelessWidget {
  const EBAppBarBottomContents({super.key});

  @override
  Widget build(BuildContext context) {
    double paddingY = 15.0;
    double iconSize = 20.0;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: paddingY),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkResponse(
            onTap: () {},
            child: GestureDetector(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                spacing: 10.0,
                children: [
                  Icon(
                    EBIcons.home,
                    size: iconSize + 3, // since it's custom the frame is diff.
                    color: EBColor.primary,
                  ),
                  EBTypography.small(
                    text: 'Sphere',
                    color: EBColor.primary,
                    fontWeight: EBFontWeight.bold,
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
                    color: EBColor.dark.withOpacity(0.5),
                  ),
                  EBTypography.small(text: 'People', muted: true),
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
                    color: EBColor.dark.withOpacity(0.5),
                  ),
                  EBTypography.small(text: 'Saved', muted: true),
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
                    FeatherIcons.settings,
                    size: iconSize,
                    color: EBColor.dark.withOpacity(0.5),
                  ),
                  EBTypography.small(text: 'Account', muted: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}