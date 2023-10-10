import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/icons.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/screens/auth/login.dart';
import 'package:ebayan/screens/resident/join_brgy.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EBTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const EBTopAppBar({Key? key}) : super(key: key);

  @override
  State<EBTopAppBar> createState() => _EBTopAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _EBTopAppBarState extends State<EBTopAppBar> {
  final joinButtonTooltipController = JustTheController();
  final drawerButtonTooltipController = JustTheController();

  bool _finishedTutorial = false;

  @override
  void initState() {
    super.initState();

    // Check if the tutorial has already been completed
    Future<void> checkTutorialStatus() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // If the tutorial is not finished, show it
      if (!(prefs.getBool('finishedTutorial') ?? false)) {
        // Function to show and hide tooltips with a delay
        Future<void> showAndHideTooltip(JustTheController controller, int delayInSeconds) async {
          await Future.delayed(Duration(seconds: delayInSeconds));
          controller.showTooltip();
          await Future.delayed(const Duration(seconds: 3));
          controller.hideTooltip();
        }

        // Show tooltips with delays
        showAndHideTooltip(joinButtonTooltipController, 1);
        showAndHideTooltip(drawerButtonTooltipController, 4);

        // Mark the tutorial as completed
        prefs.setBool('finishedTutorial', true);
      }

      // Check if the tutorial has been finished
      _finishedTutorial = prefs.getBool('finishedTutorial') ?? false;

      // Hide tooltips if the tutorial has been finished
      if (_finishedTutorial) {
        joinButtonTooltipController.hideTooltip();
        drawerButtonTooltipController.hideTooltip();
      }
    }

    // Call the tutorial check function
    checkTutorialStatus();
  }

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
      leading: JustTheTooltip(
        controller: drawerButtonTooltipController,
        backgroundColor: EBColor.primary,
        elevation: 0,
        content: const TooltipContainer(message: 'Tap here to access your sidebar.'),
        child: Container(
          margin: const EdgeInsets.fromLTRB(20.0, 0, 0, 0), // moves the drawer icon to the right more
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
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: JustTheTooltip(
            controller: joinButtonTooltipController,
            backgroundColor: EBColor.primary,
            elevation: 0,
            content: const TooltipContainer(message: 'Tap here to join a barangay!'),
            child: IconButton(
              icon: const Icon(
                FeatherIcons.plus,
                color: EBColor.primary,
              ),
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
        ),
      ],
      backgroundColor: EBColor.light,
      elevation: 1,
    );
  }

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
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
            title: EBTypography.text(text: 'Logout', color: EBColor.danger),
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
