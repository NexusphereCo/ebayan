import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/icons.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/screens/auth/login.dart';
import 'package:ebayan/screens/resident/join_brgy.dart';
import 'package:ebayan/widgets/buttons.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

class EBTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EBTopAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const iconSize = 20.0;

    return AppBar(
      iconTheme: const IconThemeData(color: EBColor.primary),
      title: Row(
        children: [
          EBTypography.h3(
            text: 'eBayan',
            color: EBColor.primary,
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(Asset.logoColorPath),
        ],
      ),
      leading: Container(
        margin: const EdgeInsets.fromLTRB(30.0, 0, 0, 0), // moves the drawer icon to the right more
        child: InkResponse(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: const Icon(
            EBIcons.menu,
            size: iconSize,
            color: EBColor.dark,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: IconButton(
            icon: const Icon(
              FeatherIcons.plus,
              color: EBColor.primary,
            ),
            tooltip: 'Join to a barangay',
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: const JoinBrgyScreen(),
                ),
              );
            },
          ),
        ),
      ],
      backgroundColor: EBColor.light,
      elevation: 1,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class EBDrawer extends StatelessWidget {
  const EBDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    const iconSize = 20.0;

    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        children: [
          SizedBox(
            height: 57.0,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      EBIcons.menu,
                      size: iconSize,
                    ),
                  ),
                ),
                EBTypography.h3(
                  text: 'eBayan',
                  color: EBColor.primary,
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(Asset.logoColorPath),
              ],
            ),
          ),
          ListTile(
            title: EBTypography.text(text: 'Dashboard'),
            onTap: () {},
          ),
          ListTile(
            title: EBTypography.text(text: 'File Complaints'),
            onTap: () {},
          ),
          ListTile(
            title: EBTypography.text(text: 'Raise Suggestions'),
            onTap: () {},
          ),
          ListTile(
            title: EBTypography.text(text: 'Account Settings'),
            onTap: () {},
          ),
          ListTile(
            title: EBTypography.text(text: 'Logout', color: EBColor.danger),
            onTap: () {
              const EBBackButton(screenDestination: LoginScreen());
            },
          ),
        ],
      ),
    );
  }
}
