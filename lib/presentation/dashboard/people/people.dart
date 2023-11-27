import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/presentation/dashboard/dashboard/widgets/card_sphere.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/shared/appbar_bottom.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({super.key});

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBAppBar(),
      drawer: const EBDrawer(),
      body: RefreshIndicator(
        color: EBColor.light,
        backgroundColor: EBColor.primary,
        onRefresh: () async => setState(() {}),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(Global.paddingBody),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EBTypography.h1(text: 'People'),
                  const SizedBox(height: Spacing.sm),
                  EBTypography.text(text: '42 people are connected in this barangay sphere'),
                  const SizedBox(height: Spacing.md),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    child: const SphereCard(
                      isLoading: true,
                    ).cardHeader(),
                  ),
                  const SizedBox(height: Spacing.md),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(FeatherIcons.user),
                          const SizedBox(width: Spacing.md),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              EBTypography.text(text: 'Johcel Gene T. Bitara'),
                              EBTypography.small(text: '0912344810', muted: true),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(FeatherIcons.moreHorizontal),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const EBAppBarBottom(activeIndex: 2),
    );
  }
}
