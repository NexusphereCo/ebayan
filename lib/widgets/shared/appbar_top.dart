import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/icons.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';

class EBAppBar extends StatefulWidget implements PreferredSizeWidget {
  const EBAppBar({Key? key}) : super(key: key);

  @override
  State<EBAppBar> createState() => _EBAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(65.0);
}

class _EBAppBarState extends State<EBAppBar> {
  @override
  Widget build(BuildContext context) {
    const iconSize = 20.0;

    return AppBar(
      iconTheme: IconThemeData(color: EBColor.primary),
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
        // moves the drawer icon to the right more
        margin: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
        child: InkResponse(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: Icon(
            EBIcons.menu,
            size: iconSize,
            color: EBColor.dark,
          ),
        ),
      ),
      backgroundColor: EBColor.light,
      elevation: 1,
    );
  }
}

class TooltipContainer extends StatelessWidget {
  final String message;

  const TooltipContainer({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    const double paddingTooltipContainer = 20.0;

    return Container(
      decoration: BoxDecoration(
        color: EBColor.primary,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(paddingTooltipContainer),
        child: EBTypography.text(text: message, color: EBColor.light),
      ),
    );
  }
}

class EBDrawer extends StatefulWidget {
  const EBDrawer({super.key});

  @override
  State<EBDrawer> createState() => _EBDrawerState();
}

class _EBDrawerState extends State<EBDrawer> {
  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();

      if (context.mounted) {
        Navigator.of(context).push(createRoute('/login'));
      }
    } catch (e) {
      var logger = Logger();
      logger.e('Sign-out failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    const iconSize = 20.0;

    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 57.0,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                  child: IconButton(
                    onPressed: () {
                      Scaffold.of(context).closeDrawer();
                    },
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
            title: EBTypography.text(text: 'Logout', color: EBColor.red),
            onTap: () {
              logOut();
            },
          ),
        ],
      ),
    );
  }
}
