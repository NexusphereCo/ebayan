import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/icons.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/presentation/dashboard/announcements/widgets/announcement_delete_modal.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EBAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool? noTitle;
  final bool? enablePop;
  final bool? more;
  final bool? save;
  final String? annId;
  final GlobalKey? drawerKey;

  const EBAppBar({
    super.key,
    this.enablePop,
    this.title,
    this.noTitle,
    this.more,
    this.save,
    this.annId,
    this.drawerKey,
  });

  @override
  State<EBAppBar> createState() => _EBAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(65.0);
}

enum CardOptions { itemOne, itemTwo, itemThree }

class _EBAppBarState extends State<EBAppBar> {
  final UserController userController = UserController();
  CardOptions? selectedMenu;

  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    checkIfSaved();
  }

  Future<void> checkIfSaved() async {
    try {
      final savedAnnouncements = await userController.getSavedAnnouncements();
      setState(() {
        isSaved = savedAnnouncements.contains(widget.annId.toString());
      });
    } catch (error) {
      print('Error checking if saved: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    /// ```dart
    /// AppBar() => default; returns a drawer with title heading and logo.
    /// AppBar(enablePop: true) => returns a back button instead of drawer with title heading and logo.
    /// AppBar(enablePop: true, noTitle: true) => returns a back button only with no content.
    /// AppBar(enablePop: true, title: Widget..) => returns a back button with a custom title.
    /// AppBar(enablePop: true, more: true)
    /// Appbar(enablePop: true, save: true)
    /// ```
    // Build the AppBar
    return AppBar(
      iconTheme: IconThemeData(color: EBColor.primary),
      backgroundColor: EBColor.light,
      elevation: 1,
      title: _buildTitle(),
      leading: _buildLeading(),
      actions: [
        _buildMoreAction(),
        _buildSaveAction(),
      ],
    );
  }

  Widget? _buildTitle() {
    if (!(widget.noTitle ?? false)) {
      return widget.title ??
          Row(
            children: [
              EBTypography.h3(
                text: 'eBayan',
                color: EBColor.primary,
              ),
              const SizedBox(width: 8),
              SvgPicture.asset(Asset.logoWColor),
            ],
          );
    }
    return null;
  }

  Widget _buildLeading() {
    const iconSize = 20.0;
    return Container(
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
                key: widget.drawerKey,
                EBIcons.menu,
                size: iconSize,
                color: EBColor.dark,
              ),
            ),
    );
  }

  Widget _buildMoreAction() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 8.0, 0),
      child: (widget.more ?? false)
          ? PopupMenuButton<CardOptions>(
              offset: const Offset(-23, 37),
              icon: Icon(
                FeatherIcons.moreVertical,
                color: EBColor.primary,
              ),
              initialValue: selectedMenu,
              onSelected: (CardOptions item) async {
                setState(() {
                  selectedMenu = item;
                });

                if (item == CardOptions.itemOne) {
                  setState(() {
                    isSaved = !isSaved;
                  });

                  switch (isSaved) {
                    case true:
                      await userController.saveAnnouncement(widget.annId.toString());
                      break;
                    case false:
                      await userController.deleteSavedAnnouncement(widget.annId.toString());
                      break;
                  }
                } else if (item == CardOptions.itemTwo) {
                  Navigator.of(context).pushReplacement(
                    createRoute(route: Routes.editAnnouncement, args: widget.annId),
                  );
                } else if (item == CardOptions.itemThree) {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return DeleteAnnouncement(
                        annId: widget.annId.toString(),
                      );
                    },
                  );
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<CardOptions>>[
                PopupMenuItem<CardOptions>(
                  value: CardOptions.itemOne,
                  height: 30,
                  child: Text(
                    isSaved ? 'Unsave Announcement' : 'Save Announcement',
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
                const PopupMenuItem<CardOptions>(
                  value: CardOptions.itemTwo,
                  height: 30,
                  child: Text(
                    'Edit Announcement',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                const PopupMenuItem<CardOptions>(
                  value: CardOptions.itemThree,
                  height: 30,
                  child: Text(
                    'Delete Announcement',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            )
          : null,
    );
  }

  Widget _buildSaveAction() {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 8.0, 0),
        child: (widget.save ?? false)
            ? IconButton(
                onPressed: () async {
                  setState(() {
                    isSaved = !isSaved;
                  });

                  switch (isSaved) {
                    case true:
                      await userController.saveAnnouncement(widget.annId.toString());
                      break;
                    case false:
                      await userController.deleteSavedAnnouncement(widget.annId.toString());
                      break;
                  }
                },
                icon: Icon(
                  isSaved ? FontAwesomeIcons.solidBookmark : FontAwesomeIcons.bookmark,
                  color: EBColor.primary,
                ),
              )
            : null);
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
                SvgPicture.asset(Asset.logoWColor),
              ],
            ),
          ),
          ListTile(
            title: EBTypography.text(text: 'Dashboard'),
            onTap: () {
              if (ModalRoute.of(context)?.settings.name != Routes.dashboard) {
                Navigator.of(context).push(createRoute(route: Routes.dashboard));
              }
            },
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
            onTap: () {
              if (ModalRoute.of(context)?.settings.name != Routes.accountInfo) {
                Navigator.of(context).push(createRoute(route: Routes.accountInfo));
              }
            },
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
