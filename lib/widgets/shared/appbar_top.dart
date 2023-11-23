import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/icons.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EBAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool? noTitle;
  final bool? enablePop;

  const EBAppBar({
    Key? key,
    this.enablePop,
    this.title,
    this.noTitle,
  }) : super(key: key);

  @override
  State<EBAppBar> createState() => _EBAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(65.0);
}

class _EBAppBarState extends State<EBAppBar> {
  @override
  Widget build(BuildContext context) {
    const iconSize = 20.0;

    /// ```dart
    /// AppBar() => default; returns a drawer with title heading and logo.
    /// AppBar(enablePop: true) => returns a back button instead of drawer with title heading and logo.
    /// AppBar(enablePop: true, noTitle: true) => returns a back button only with no content.
    /// AppBar(enablePop: true, title: Widget..) => returns a back button with a custom title.
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
        margin: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
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
    );
  }
}

class EBDrawer extends StatefulWidget {
  const EBDrawer({super.key});

  @override
  State<EBDrawer> createState() => _EBDrawerState();
}

class _EBDrawerState extends State<EBDrawer> {
  final UserController _userController = UserController();
  final EBLoadingScreen _loadingScreen = const EBLoadingScreen();

  Future<void> _logOut() async {
    _loadingScreen.show(context);

    await _userController.logOut();

    if (context.mounted) {
      _loadingScreen.hide(context);
      Navigator.of(context).push(createRoute(route: Routes.login));
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
