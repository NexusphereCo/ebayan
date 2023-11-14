import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/card_sphere.dart';
import 'package:ebayan/widgets/shared/appbar_bottom.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class JoinedDashboardView extends StatelessWidget {
  const JoinedDashboardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBAppBar(),
      drawer: const EBDrawer(),
      body: ListView(
        children: [
          Expanded(
            child: Column(
              children: [
                Column(
                  children: [
                    const SizedBox(height: Spacing.md),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        EBTypography.h1(text: 'Welcome Back, '),
                        EBTypography.h1(
                          text: 'Jane!',
                          color: EBColor.primary,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.md),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          color: EBColor.primary[300],
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 200, // Set the desired height
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                for (int i = 0; i < 7; i++)
                                  Container(
                                    width: 300,
                                    margin: const EdgeInsets.all(10.0),
                                    color: EBColor.primary,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Spacing.md),
                const SphereCard(),
              ],
            ),
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