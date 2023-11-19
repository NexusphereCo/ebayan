import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/shared/appbar_bottom.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/card_sphere.dart';
import '../widgets/heading.dart';
import '../widgets/loading_bar.dart';

class JoinedDashboardLoadingView extends StatefulWidget {
  const JoinedDashboardLoadingView({
    Key? key,
  }) : super(key: key);

  @override
  State<JoinedDashboardLoadingView> createState() => _JoinedDashboardLoadingViewState();
}

class _JoinedDashboardLoadingViewState extends State<JoinedDashboardLoadingView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: const EBAppBar(),
          drawer: const EBDrawer(),
          body: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildHeading(),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(EBBorderRadius.lg),
                          bottomLeft: Radius.circular(EBBorderRadius.lg),
                        ),
                        color: EBColor.dullGreen[50],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: SvgPicture.asset(
                              Asset.illustRecentAnnCircleBackg,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 20, 0, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                EBTypography.h3(text: 'Recent Announcement'),
                                EBTypography.text(text: 'Here\'s your recent announcements from your barangay.'),
                                SizedBox(
                                  height: 190,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return Container(
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
                                                  Asset.illustRecentAnnCardWaveBackg,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: Spacing.md, vertical: Spacing.lg),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          padding: const EdgeInsets.symmetric(horizontal: EBBorderRadius.md, vertical: EBBorderRadius.xs),
                                                          decoration: BoxDecoration(
                                                            color: EBColor.green,
                                                            borderRadius: const BorderRadius.all(Radius.circular(EBBorderRadius.lg)),
                                                          ),
                                                          child: const SizedBox(width: 50, height: 12),
                                                        ),
                                                        buildLoadingContainer(width: 50),
                                                      ],
                                                    ),
                                                    const SizedBox(height: Spacing.md),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Icon(FeatherIcons.circle, color: EBColor.green),
                                                        const SizedBox(width: Spacing.sm),
                                                        buildLoadingContainer(width: 50),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const SizedBox(height: Spacing.sm),
                                                        buildLoadingContainer(width: double.infinity),
                                                        const SizedBox(height: Spacing.sm),
                                                        buildLoadingContainer(width: 100),
                                                      ],
                                                    ),
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
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: Spacing.lg),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Global.paddingBody),
                    child: EBTypography.h3(text: 'Barangay Sphere'),
                  ),
                  const SphereCard(isLoading: true),
                ],
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(createRoute(route: '/dashboard/join_brgy'));
            },
            child: const Icon(FeatherIcons.plus),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const EBAppBarBottom(activeIndex: 1),
        ),
        Center(
          child: CircularProgressIndicator(
            color: EBColor.primary,
            strokeCap: StrokeCap.round,
          ),
        )
      ],
    );
  }
}
