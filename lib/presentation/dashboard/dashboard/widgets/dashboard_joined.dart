import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/global.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/card_sphere.dart';
import 'package:ebayan/widgets/shared/appbar_bottom.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'heading.dart';

class JoinedDashboardView extends StatefulWidget {
  const JoinedDashboardView({super.key});

  @override
  State<JoinedDashboardView> createState() => _JoinedDashboardViewState();
}

class _JoinedDashboardViewState extends State<JoinedDashboardView> {
  @override
  void initState() {
    connectionHandler(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBAppBar(),
      drawer: const EBDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: Spacing.md),
          buildHeading(),
          const SizedBox(height: Spacing.md),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20.0, 20, 0, 20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(EBBorderRadius.lg),
                  bottomLeft: Radius.circular(EBBorderRadius.lg),
                ),
                color: EBColor.dullGreen[50],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EBTypography.h3(text: 'Recent Announcement'),
                  EBTypography.text(text: 'Here\'s your recent announcements from your barangay.'),
                  SizedBox(
                    height: 190,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context, index) => Container(
                        width: 300,
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(EBBorderRadius.lg),
                          border: Border.all(color: EBColor.dullGreen),
                          color: EBColor.light,
                          boxShadow: [
                            BoxShadow(
                              color: EBColor.dullGreen[500]!.withOpacity(0.35),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(EBBorderRadius.lg),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: SvgPicture.asset(
                                  'assets/svgs/illustration/card-recent-ann-wave.svg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: Spacing.md, vertical: Spacing.md),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        EBTypography.label(text: 'Important'),
                                        EBTypography.small(text: 'Jan 1'),
                                      ],
                                    ),
                                    const SizedBox(height: Spacing.md),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(FeatherIcons.user, color: EBColor.dark),
                                        const SizedBox(width: Spacing.sm),
                                        EBTypography.h4(text: 'John Doe'),
                                      ],
                                    ),
                                    const SizedBox(height: Spacing.sm),
                                    EBTypography.text(text: 'Barangay Community Potluck Picnic: Let\'s Celebrate Together!'),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(FeatherIcons.arrowRight),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: Spacing.lg),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Global.paddingBody),
            child: EBTypography.h3(text: 'Barangay Sphere'),
          ),
          const SphereCard(
            brgyName: 'San Felipe, Naga City',
            brgyCode: '90124',
            hasNewAnnouncements: false,
            numOfPeople: 32,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(createRoute(route: '/dashboard/join_brgy'));
        },
        child: const Icon(FeatherIcons.plus),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const EBAppBarBottom(),
    );
  }
}
