import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmptySavedAnnouncements extends StatelessWidget {
  const EmptySavedAnnouncements({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            EBTypography.h1(text: 'Announcement'),
            const SizedBox(width: Spacing.sm),
            FaIcon(FontAwesomeIcons.solidBookmark, size: 30, color: EBColor.dark),
          ],
        ),
        const SizedBox(height: Spacing.xxl),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(Asset.noAnnouncements),
                EBTypography.h2(text: 'No Saved Announcements'),
                const SizedBox(height: Spacing.sm),
                EBTypography.label(
                  text: 'Start by saving your favorite posts.',
                  muted: true,
                  fontWeight: EBFontWeight.regular,
                ),
                const SizedBox(height: Spacing.lg),
                EBButton(
                  onPressed: () {
                    Navigator.of(context).push(createRoute(route: Routes.announcements));
                  },
                  text: 'Browse for Announcements',
                  theme: EBButtonTheme.primaryOutlined,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
