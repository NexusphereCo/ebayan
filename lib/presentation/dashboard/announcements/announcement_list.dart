import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/anct_controller.dart';
import 'package:ebayan/controller/brgy_controller.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/data/model/announcement_model.dart';
import 'package:ebayan/data/viewmodel/barangay_view_model.dart';
import 'package:ebayan/presentation/dashboard/announcements/widgets/announcement_card.dart';
import 'package:ebayan/presentation/dashboard/dashboard/widgets/card_sphere.dart';
import 'package:ebayan/utils/global.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:ebayan/widgets/utils/rotate_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'widgets/heading.dart';

class AnnouncementListScreen extends StatefulWidget {
  const AnnouncementListScreen({super.key});

  @override
  State<AnnouncementListScreen> createState() => _AnnouncementListScreenState();
}

class _AnnouncementListScreenState extends State<AnnouncementListScreen> {
  final EBLoadingScreen loadingScreen = const EBLoadingScreen();

  // Controllers
  final AnnouncementController announcementController = AnnouncementController();
  final BarangayController brgyController = BarangayController();
  final UserController userController = UserController();

  // Variables
  List<AnnouncementModel> announcements = [];

  @override
  void initState() {
    connectionHandler(context);
    super.initState();
    fetchAnnouncements();
  }

  Future<BarangayViewModel> fetchBarangayInfo() async {
    final user = await userController.getCurrentUserInfo();
    return await brgyController.fetchBarangayWithLatestAnnouncement(user.barangayAssociated as String);
  }

  Future<void> fetchAnnouncements() async {
    try {
      final List<AnnouncementModel> fetchedAnnouncements = await announcementController.fetchAnnouncements();
      setState(() {
        announcements = fetchedAnnouncements;
      });
    } catch (e) {
      throw 'An error occurred while fetching announcements.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BarangayViewModel>(
      future: fetchBarangayInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const EBLoadingScreen(solid: true);
        } else {
          final BarangayViewModel barangay = snapshot.data!;

          final floatingActionButton = SizedBox(
            width: 70.0,
            height: 70.0,
            child: FittedBox(
              child: FloatingActionButton(
                backgroundColor: EBColor.green,
                onPressed: () => Navigator.of(context).push(createRoute(route: Routes.createAnnouncement)),
                child: Icon(FontAwesomeIcons.pencil, color: EBColor.light, size: EBFontSize.h3),
              ),
            ),
          );

          return Scaffold(
            appBar: const EBAppBar(enablePop: true),
            drawer: const EBDrawer(),
            floatingActionButton: floatingActionButton,
            body: RefreshIndicator(
              onRefresh: () async => setState(() {}),
              child: ListView.builder(
                padding: const EdgeInsets.all(Global.paddingBody),
                itemCount: announcements.length,
                itemBuilder: (context, index) {
                  // Render out the announcement cards
                  return Column(
                    children: [
                      if (index == 0) buildHeading(barangay: barangay),
                      AnnouncementCard(announcement: announcements[index]),
                    ],
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
