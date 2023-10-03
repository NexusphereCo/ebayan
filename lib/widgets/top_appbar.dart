import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class EBTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EBTopAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: EBTypography.h1(text: 'eBayan'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(FeatherIcons.plus),
          tooltip: 'Join to a barangay',
          onPressed: () {},
        ),
      ],
      backgroundColor: EBColor.dark,
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
              color: Colors.amber,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Calculator'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Account'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
