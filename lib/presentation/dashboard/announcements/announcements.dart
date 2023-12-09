import 'dart:math';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/anct_controller.dart';
import 'package:ebayan/controller/brgy_controller.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/data/model/announcement_model.dart';
import 'package:ebayan/data/viewmodel/barangay_view_model.dart';
import 'package:ebayan/presentation/dashboard/announcements/widgets/announcement_list.dart';
import 'package:ebayan/presentation/dashboard/dashboard/widgets/card_sphere.dart';
import 'package:ebayan/utils/global.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnnouncementListScreen extends StatefulWidget {
  const AnnouncementListScreen({Key? key}) : super(key: key);

  @override
  State<AnnouncementListScreen> createState() => _AnnouncementListScreenState();
}

class _AnnouncementListScreenState extends State<AnnouncementListScreen> {
  final AnnouncementController _announcementController = AnnouncementController();
  List<AnnouncementModel> announcements = [];
  final BarangayController _brgyController = BarangayController();
  final UserController _userController = UserController();

  bool isFetchingAnnouncements = false;

  Future<BarangayViewModel> fetchBarangayInfo() async {
    final user = await _userController.getCurrentUserInfo();
    final barangay = await _brgyController.fetchBarangayWithLatestAnnouncement(user.barangayAssociated as String);

    return barangay;
  }

  @override
  void initState() {
    super.initState();
    connectionHandler(context);
    refresh();
  }

  Future<void> fetchAnnouncements() async {
    try {
      final List<AnnouncementModel> fetchedAnnouncements = await _announcementController.fetchAnnouncements();
      setState(() {
        announcements = fetchedAnnouncements;
      });
    } catch (e) {
      throw 'An error occurred while fetching announcements.';
    } finally {
      setState(() {
        isFetchingAnnouncements = false;
      });
    }
  }

  Future<void> refresh() async {
    setState(() {
      isFetchingAnnouncements = true;
    });
    await fetchAnnouncements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBAppBar(enablePop: true),
      drawer: const EBDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(createRoute(route: Routes.createAnnouncement)),
        child: const Icon(FontAwesomeIcons.pencil),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Global.paddingBody),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: Global.paddingBody),
                      child: Row(
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
                    ),
                    const SizedBox(height: Spacing.md),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      child: FutureBuilder(
                        future: fetchBarangayInfo(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const SphereCard(isLoading: true).cardHeader();
                          } else {
                            BarangayViewModel data = snapshot.data!;
                            return SphereCard(
                              brgyName: data.name,
                              brgyCode: data.code.toString(),
                            ).cardHeader();
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: Spacing.md),
                  ],
                ),
              ),
              if (isFetchingAnnouncements)
                SliverFillRemaining(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(
                          color: EBColor.primary,
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                      const SizedBox(height: Spacing.md),
                      EBTypography.text(
                        text: 'Loading...',
                        color: EBColor.primary,
                      ),
                    ],
                  ),
                )
              else
                AnnouncementList(announcements: announcements),
            ],
          ),
        ),
      ),
    );
  }
}
