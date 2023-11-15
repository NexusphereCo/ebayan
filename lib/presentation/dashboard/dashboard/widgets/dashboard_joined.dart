import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/utils/global.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/card_sphere.dart';
import 'package:ebayan/widgets/shared/appbar_bottom.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      7,
                      (index) => Container(
                        width: 300,
                        height: 150,
                        margin: const EdgeInsets.all(10.0),
                        color: EBColor.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: Spacing.md),
          const SphereCard(),
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
