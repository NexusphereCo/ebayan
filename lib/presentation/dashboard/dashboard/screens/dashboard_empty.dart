import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/global.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/shared/appbar_bottom.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/heading.dart';

class EmptyDashboardView extends StatefulWidget {
  const EmptyDashboardView({
    super.key,
  });

  @override
  State<EmptyDashboardView> createState() => _EmptyDashboardViewState();
}

class _EmptyDashboardViewState extends State<EmptyDashboardView> {
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
      body: Padding(
        padding: const EdgeInsets.all(Global.paddingBody),
        child: Column(
          children: [
            buildHeading(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SvgPicture.asset(Asset.illustHouseEmptyPath),
                      const SizedBox(height: Spacing.lg),
                      EBTypography.text(
                        text: "You currently aren't joined to any barangay spheres. Let's change that!",
                        muted: true,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: Spacing.lg),
                  SizedBox(
                    width: double.infinity,
                    child: EBButton(
                      onPressed: () {
                        Navigator.of(context).push(createRoute(route: Routes.joinBrgy));
                      },
                      text: 'Get Started!',
                      theme: EBButtonTheme.primary,
                    ),
                  ),
                  const SizedBox(height: Spacing.lg),
                  const SizedBox(height: Spacing.lg),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(createRoute(route: Routes.joinBrgy));
        },
        child: const Icon(FeatherIcons.plus),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const EBAppBarBottom(activeIndex: 1),
    );
  }
}
