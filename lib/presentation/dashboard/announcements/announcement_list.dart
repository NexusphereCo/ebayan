import 'dart:math';
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
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnnouncementListScreen extends StatefulWidget {
  const AnnouncementListScreen({super.key});

  @override
  State<AnnouncementListScreen> createState() => _AnnouncementListScreenState();
}

class _AnnouncementListScreenState extends State<AnnouncementListScreen> {
  final AnnouncementController _announcementController = AnnouncementController();
  List<AnnouncementModel> announcements = [];
  final BarangayController _brgyController = BarangayController();
  final UserController _userController = UserController();

  final EBLoadingScreen loadingScreen = const EBLoadingScreen();

  Future<BarangayViewModel> _fetchBarangayInfo() async {
    final user = await _userController.getCurrentUserInfo();
    final barangay = await _brgyController.fetchBarangayWithLatestAnnouncement(user.barangayAssociated as String);

    return barangay;
  }

  @override
  void initState() {
    connectionHandler(context);
    _refresh();
    super.initState();
  }

  Future<void> _fetchAnnouncements() async {
    try {
      final List<AnnouncementModel> fetchedAnnouncements = await _announcementController.fetchAnnouncements();
      setState(() {
        announcements = fetchedAnnouncements;
      });
    } catch (e) {
      throw 'An error occurred while fetching announcements.';
    }
  }

  Future<void> _refresh() async {
    await _fetchAnnouncements();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BarangayViewModel>(
      future: _fetchBarangayInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const EBLoadingScreen(
            solid: true,
          );
        } else {
          final BarangayViewModel barangay = snapshot.data!;

          return Scaffold(
            appBar: const EBAppBar(enablePop: true),
            drawer: const EBDrawer(),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.of(context).push(createRoute(route: Routes.createAnnouncement)),
              child: const Icon(Icons.add),
            ),
            body: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                padding: const EdgeInsets.all(24.0),
                itemCount: announcements.length + 1,
                itemBuilder: (context, index) {
                  final dataIndex = index - 1;
                  if (index == 0) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            EBTypography.h1(text: 'Announcement'),
                            const SizedBox(width: Spacing.sm),
                            Transform.rotate(
                              angle: -15 * pi / 180,
                              child: FaIcon(
                                FontAwesomeIcons.bullhorn,
                                size: 30,
                                color: EBColor.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: Spacing.md),
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                          child: SphereCard(
                            brgyName: barangay.name,
                            brgyCode: barangay.code.toString(),
                          ).cardHeader(),
                        ),
                        const SizedBox(height: Spacing.md),
                      ],
                    );
                  } else {
                    return AnnouncementCard(
                      announcement: announcements[dataIndex],
                    );
                  }
                },
              ),
            ),
          );
        }
      },
    );
  }
}
