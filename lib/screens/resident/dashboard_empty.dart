import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/screens/resident/announcement.dart';
import 'package:ebayan/screens/resident/join_brgy.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/bottom_appbar.dart';
import 'package:ebayan/widgets/buttons.dart';
import 'package:ebayan/widgets/top_appbar.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

/*
  Authored by: Miguel Damien L. Garcera
  Company: NexusphereCo.
  Project: eBayan
  Feature: [EB-004] Dashboard (Resident) Screen
  Description: a dashboard screen for brgy. officials/residents to use. 
    after registering/logging in, users are redirected to this dashboard
    screen which will contain their list of barangay spheres.

    users after creating an account, will have an interactive guide/tutorial
    for navigating the dashboard.
 */

class DashboardEmptyScreen extends StatelessWidget {
  const DashboardEmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const EBTopAppBar(),
        drawer: const EBDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Global.paddingBody),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EBTypography.h1(text: 'Welcome Back, '),
                  EBTypography.h1(
                    text: 'Jane!',
                    color: EBColor.primary,
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset(Asset.illustHouseEmptyPath),
                        const SizedBox(height: Spacing.formLg),
                        EBTypography.text(
                          text: "You currently aren't joined to any barangay spheres. Let's change that!",
                          muted: true,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: Spacing.formLg),
                    SizedBox(
                      width: double.infinity,
                      child: EBButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: const JoinBrgyScreen(),
                            ),
                          );
                        },
                        text: 'Get Started!',
                        theme: EBButtonTheme.primary,
                      ),
                    ),
                    const SizedBox(height: Spacing.formLg),
                    const SizedBox(height: Spacing.formLg),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const EBBottomAppBar(),
      ),
    );
  }
}

enum SampleItem { itemOne, itemTwo, itemThree }

class SphereCard extends StatefulWidget {
  const SphereCard({
    super.key,
  });

  @override
  State<SphereCard> createState() => _SphereCardState();
}

class _SphereCardState extends State<SphereCard> {
  SampleItem? selectedMenu;

  Widget _cardHeader() {
    return Container(
      width: double.infinity,
      height: 125,
      color: EBColor.primary,
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  EBTypography.h4(text: 'San Felipe, Naga City', color: EBColor.light),
                  EBTypography.small(text: '092174', color: EBColor.light),
                  const SizedBox(height: Spacing.formMd),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(Asset.illustHousePath, fit: BoxFit.fitHeight),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardFooter() {
    return Container(
      width: double.infinity,
      height: 75,
      color: EBColor.light,
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const FaIcon(FontAwesomeIcons.bullhorn, size: 16),
                      const SizedBox(width: 10),
                      EBTypography.small(text: 'New announcement 1hr ago'),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(FeatherIcons.user, size: 16),
                      const SizedBox(width: 10),
                      EBTypography.small(text: '42 people'),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  EBButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const AnnouncementScreen(),
                          ),
                        );
                      },
                      text: 'View',
                      theme: EBButtonTheme.primary),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardOption() {
    return Positioned(
      top: 0,
      right: 10.0,
      child: PopupMenuButton<SampleItem>(
        offset: const Offset(0, 40),
        icon: const Icon(
          FeatherIcons.moreHorizontal,
          color: EBColor.light,
        ),
        initialValue: selectedMenu,
        onSelected: (SampleItem item) {
          setState(() {
            selectedMenu = item;
          });
          if (item == SampleItem.itemOne) {
            const snackBar = SnackBar(
              content: Text('Brgy. sphere code has been copied to clipboard.'),
              backgroundColor: EBColor.primary,
              elevation: 1,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
          const PopupMenuItem<SampleItem>(
            value: SampleItem.itemOne,
            child: Text('Copy Code'),
          ),
          const PopupMenuItem<SampleItem>(
            value: SampleItem.itemTwo,
            child: Text('Leave Barangay Sphere'),
          ),
          const PopupMenuItem<SampleItem>(
            value: SampleItem.itemThree,
            child: Text('View People'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      border: Border.all(
        width: 3,
        color: EBColor.primary,
      ),
    );

    const borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(15.0),
      bottomRight: Radius.circular(15.0),
      topLeft: Radius.circular(5.0),
      topRight: Radius.circular(5.0),
    );

    return Container(
      decoration: decoration,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Stack(
          children: [
            Column(
              children: [
                _cardHeader(),
                _cardFooter(),
              ],
            ),
            _cardOption(),
          ],
        ),
      ),
    );
  }
}
