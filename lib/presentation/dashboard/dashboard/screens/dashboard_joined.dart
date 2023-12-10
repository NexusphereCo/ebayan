import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/brgy_controller.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/data/viewmodel/barangay_view_model.dart';
import 'package:ebayan/utils/global.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/widgets/layout_components/appbar_bottom.dart';
import 'package:ebayan/widgets/layout_components/appbar_top.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import '../widgets/card_announcement.dart';
import '../widgets/card_sphere.dart';
import '../widgets/heading.dart';
import 'dashboard_loading.dart';

class JoinedDashboardView extends StatefulWidget {
  const JoinedDashboardView({super.key});

  @override
  State<JoinedDashboardView> createState() => _JoinedDashboardViewState();
}

class _JoinedDashboardViewState extends State<JoinedDashboardView> {
  final BarangayController brgyController = BarangayController();
  final UserController userController = UserController();

  Future<BarangayViewModel> fetchBarangayInfo() async {
    final user = await userController.getCurrentUserInfo();
    final barangay = await brgyController.fetchBarangayWithLatestAnnouncement(user.barangayAssociated as String);

    return barangay;
  }

  @override
  void initState() {
    connectionHandler(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BarangayViewModel>(
      future: fetchBarangayInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const JoinedDashboardLoadingView();
        } else {
          final BarangayViewModel barangay = snapshot.data!;

          return Scaffold(
            appBar: const EBAppBar(),
            drawer: const EBDrawer(),
            body: RefreshIndicator(
              color: EBColor.light,
              backgroundColor: EBColor.dullGreen,
              onRefresh: () async => setState(() {}),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buildHeading(),
                      buildLatestAnnouncements(announcements: barangay.announcements!),
                      const SizedBox(height: Spacing.lg),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Global.paddingBody),
                        child: EBTypography.h3(text: 'Barangay Sphere'),
                      ),
                      SphereCard(
                        brgyName: barangay.name,
                        brgyCode: barangay.code.toString(),
                        hasNewAnnouncements: barangay.announcements?.isNotEmpty,
                        numOfPeople: barangay.numOfPeople,
                      ),
                    ],
                  )
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
      },
    );
  }
}
