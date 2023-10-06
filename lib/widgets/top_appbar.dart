import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/screens/auth/login.dart';
import 'package:ebayan/screens/resident/join_brgy.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

class EBTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String _logoPath = 'assets/svgs/ebayan/logo-color.svg';

  const EBTopAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: EBColor.primary),
      title: Row(
        children: [
          EBTypography.h3(text: 'eBayan', color: EBColor.primary),
          const SizedBox(width: 8),
          SvgPicture.asset(_logoPath),
        ],
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
              Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: const JoinBrgyScreen()));
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
  final String _logoPath = 'assets/svgs/ebayan/logo-color.svg';

  const EBDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        children: [
          DrawerHeader(
            child: Row(
              children: [
                EBTypography.h3(text: 'eBayan', color: EBColor.primary),
                const SizedBox(width: 8),
                SvgPicture.asset(_logoPath),
              ],
            ),
          ),
          ListTile(
            title: EBTypography.p(text: 'Dashboard'),
            onTap: () {},
          ),
          ListTile(
            title: EBTypography.p(text: 'File Complaints'),
            onTap: () {},
          ),
          ListTile(
            title: EBTypography.p(text: 'Raise Suggestions'),
            onTap: () {},
          ),
          ListTile(
            title: EBTypography.p(text: 'Account Settings'),
            onTap: () {},
          ),
          ListTile(
            title: EBTypography.p(text: 'Logout', color: EBColor.danger),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.leftToRight,
                  child: const LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
