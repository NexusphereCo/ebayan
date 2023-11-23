import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/icons.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/presentation/dashboard/announcements/widgets/dialog_box.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';

class EBAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool? noTitle;
  final bool? enablePop;
  final bool? more;
  final String? annId;

  const EBAppBar({
    Key? key,
    this.enablePop,
    this.title,
    this.noTitle,
    this.more,
    this.annId,
  }) : super(key: key);

  @override
  State<EBAppBar> createState() => _EBAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(65.0);
}

enum CardOptions { itemOne, itemTwo }

class _EBAppBarState extends State<EBAppBar> {
  CardOptions? selectedMenu;

  @override
  Widget build(BuildContext context) {
    const iconSize = 20.0;

    /// ```dart
    /// AppBar() => default; returns a drawer with title heading and logo.
    /// AppBar(enablePop: true) => returns a back button instead of drawer with title heading and logo.
    /// AppBar(enablePop: true, noTitle: true) => returns a back button only with no content.
    /// AppBar(enablePop: true, title: Widget..) => returns a back button with a custom title.
    /// AppBar(enablePop: true, more: true)
    /// ```
    return AppBar(
      iconTheme: IconThemeData(color: EBColor.primary),
      backgroundColor: EBColor.light,
      elevation: 1,
      title: !(widget.noTitle ?? false)
          ? widget.title ??
              Row(
                children: [
                  EBTypography.h3(
                    text: 'eBayan',
                    color: EBColor.primary,
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset(Asset.logoColorPath),
                ],
              )
          : null,
      leading: Container(
        // moves the drawer icon to the right more
        margin: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
        child: (widget.enablePop ?? false)
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  FeatherIcons.arrowLeft,
                  color: EBColor.primary,
                ),
              )
            : InkResponse(
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
      actions: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 8.0, 0),
          child: (widget.more ?? false)
              ? PopupMenuButton<CardOptions>(
                  offset: const Offset(-18, 35),
                  icon: Icon(
                    FeatherIcons.moreVertical,
                    color: EBColor.primary,
                  ),
                  initialValue: selectedMenu,
                  onSelected: (CardOptions item) {
                    setState(() {
                      selectedMenu = item;
                    });
                    if (item == CardOptions.itemOne) {
                      Navigator.pushNamed(
                        context,
                        Routes.editAnnouncement,
                        arguments: widget.annId,
                      );
                    } else if (item == CardOptions.itemTwo) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DeleteAnnouncementBox(
                            annId: widget.annId.toString(),
                          );
                        },
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<CardOptions>>[
                    const PopupMenuItem<CardOptions>(
                      value: CardOptions.itemOne,
                      height: 30,
                      child: Text(
                        'Edit Announcement',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    const PopupMenuItem<CardOptions>(
                      value: CardOptions.itemTwo,
                      height: 30,
                      child: Text(
                        'Delete Announcement',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                )
              : null, // Add this line to handle the case when more is false
        ),
      ],
    );
  }
}

class EBDrawer extends StatefulWidget {
  const EBDrawer({super.key});

  @override
  State<EBDrawer> createState() => _EBDrawerState();
}

class _EBDrawerState extends State<EBDrawer> {
  final Logger log = Logger();

  Future<void> _logOut() async {
    try {
      await FirebaseAuth.instance.signOut();

      if (context.mounted) {
        Navigator.of(context).push(createRoute(route: '/login'));
      }
    } catch (e) {
      log.e('Sign-out failed: $e');
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
              _logOut();
            },
          ),
        ],
      ),
    );
  }
}
