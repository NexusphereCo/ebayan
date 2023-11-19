import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/brgy_controller.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/data/viewmodel/announcement_view_model.dart';
import 'package:ebayan/utils/global.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/presentation/dashboard/dashboard/widgets/card_sphere.dart';
import 'package:ebayan/widgets/components/snackbar.dart';
import 'package:ebayan/widgets/shared/appbar_bottom.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'announcement_card.dart';
import 'heading.dart';

class JoinedDashboardView extends StatefulWidget {
  const JoinedDashboardView({
    Key? key,
  }) : super(key: key);

  @override
  State<JoinedDashboardView> createState() => _JoinedDashboardViewState();
}

class _JoinedDashboardViewState extends State<JoinedDashboardView> {
  final BarangayController _brgyController = BarangayController();
  final UserController _userController = UserController();

  // variables
  String barangayName = '∙∙∙';
  String barangayCode = '∙∙∙';
  bool hasAnnouncements = false;
  int barangayResidentsCount = 0;
  List<AnnouncementViewModel> latestAnnouncements = [];

  bool isLoadingBrgyInfo = false;

  Future<void> _fetchBarangayInfo() async {
    setState(() => isLoadingBrgyInfo = true);
    try {
      final user = await _userController.getCurrentUserInfo();
      final barangay = await _brgyController.fetchBarangay(user.barangayAssociated as String);

      setState(() {
        barangayName = barangay.name;
        barangayCode = barangay.code.toString();
        hasAnnouncements = barangay.announcements!.isNotEmpty;
        barangayResidentsCount = barangay.numOfPeople ?? 0;
        latestAnnouncements = barangay.announcements!;
      });
    } catch (e) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(EBSnackBar.info(text: e.toString()));
    }

    setState(() => isLoadingBrgyInfo = false);
  }

  @override
  void initState() {
    connectionHandler(context);
    _fetchBarangayInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBAppBar(),
      drawer: const EBDrawer(),
      body: RefreshIndicator(
        color: EBColor.light,
        backgroundColor: EBColor.primary,
        onRefresh: () async => setState(() {
          _fetchBarangayInfo();
        }),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: Spacing.md),
                buildHeading(),
                const SizedBox(height: Spacing.lg),
                (latestAnnouncements.isNotEmpty) ? buildAnnouncementCard(announcements: latestAnnouncements) : buildEmptyAnnouncements(),
                const SizedBox(height: Spacing.lg),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Global.paddingBody),
                  child: EBTypography.h3(text: 'Barangay Sphere'),
                ),
                Stack(
                  children: [
                    SphereCard(
                      brgyName: barangayName,
                      brgyCode: barangayCode,
                      hasNewAnnouncements: hasAnnouncements,
                      numOfPeople: barangayResidentsCount,
                    ),
                    (isLoadingBrgyInfo)
                        ? Positioned.fill(
                            child: Center(
                              child: CircularProgressIndicator(color: EBColor.light, strokeCap: StrokeCap.round),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ],
            )
          ],
        ),
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

Widget buildEmptyAnnouncements() {
  return Container(
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
              Asset.illustRecentAnnNone,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20, 0, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EBTypography.h3(text: 'Recent Announcement'),
                EBTypography.text(text: 'There\'s currently no recent announcement from your barangay. \n\nCheck back later!'),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
