import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/presentation/dashboard/dashboard/widgets/card_sphere.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/widgets/utils/fade_in.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

Widget buildDashboard({
  required GlobalKey cardAnnouncementsKey,
  required GlobalKey cardSphereKey,
}) {
  return ListView(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              const SizedBox(height: Spacing.md),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  EBTypography.h1(text: 'Welcome Back, '),
                  EBTypography.h1(text: 'User', color: EBColor.green),
                  EBTypography.h1(text: '!', color: EBColor.green),
                ],
              ),
              const SizedBox(height: Spacing.lg),
            ],
          ),
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
                      Asset.recentAnnCircle,
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
                          key: cardAnnouncementsKey,
                          height: 190,
                          child: FadeIn(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
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
                                          Asset.recentAnnWave,
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
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: EBBorderRadius.md, vertical: EBBorderRadius.xs),
                                                  decoration: BoxDecoration(
                                                    color: EBColor.green,
                                                    borderRadius: const BorderRadius.all(Radius.circular(EBBorderRadius.lg)),
                                                  ),
                                                  child: EBTypography.label(text: 'Important', color: EBColor.light),
                                                ),
                                                EBTypography.small(text: DateFormat('MMM d').format(DateTime(2023, 1, 10))),
                                              ],
                                            ),
                                            const SizedBox(height: Spacing.md),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(FeatherIcons.user, color: EBColor.dark),
                                                const SizedBox(width: Spacing.sm),
                                                EBTypography.h4(text: 'Author'),
                                              ],
                                            ),
                                            const SizedBox(height: Spacing.sm),
                                            EBTypography.text(
                                              text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod',
                                              cutOverflow: true,
                                              maxLines: 2,
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
                              ),
                            ),
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
          SphereCard(
            key: cardSphereKey,
            brgyName: 'SAN FELIPE, CAMARINES SUR',
            brgyCode: '77241',
            hasNewAnnouncements: true,
            numOfPeople: 32,
          ),
        ],
      )
    ],
  );
}
