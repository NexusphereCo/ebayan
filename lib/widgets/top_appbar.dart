import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EBTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String _logoPath = 'assets/svgs/ebayan/logo-color.svg';

  const EBTopAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: EBColor.primary),
      title: Row(
        children: [
          EBTypography.h2(text: 'eBayan', color: EBColor.primary),
          SizedBox(width: 8),
          SvgPicture.asset(_logoPath),
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            FeatherIcons.plus,
            color: EBColor.primary,
          ),
          tooltip: 'Join to a barangay',
          onPressed: () {},
        ),
      ],
      backgroundColor: EBColor.light,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class EBDrawer extends StatelessWidget {
  const EBDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: EBColor.primary,
            ),
            child: null,
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
            title: EBTypography.p(
                text: 'Logout', color: Color.fromRGBO(246, 64, 64, 100)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
