import 'dart:math';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/anct_controller.dart';
import 'package:ebayan/data/model/announcement_model.dart';
import 'package:ebayan/data/model/barangay_model.dart';
import 'package:ebayan/presentation/dashboard/announcements/widgets/announcement_card.dart';
import 'package:ebayan/presentation/dashboard/announcements/widgets/card_header.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';

// use widget card_header and announcement_card

class AnnouncementListScreen extends StatefulWidget {
  const AnnouncementListScreen({super.key});

  @override
  State<AnnouncementListScreen> createState() => _AnnouncementListScreenState();
}

class _AnnouncementListScreenState extends State<AnnouncementListScreen> {
  final Logger log = Logger();
  final AnnouncementController _announcementController = AnnouncementController();
  List<AnnouncementModel> announcements = [];

  @override
  void initState() {
    super.initState();
    _fetchAnnouncements();
  }

  Future<void> _fetchAnnouncements() async {
    try {
      final List<AnnouncementModel> fetchedAnnouncements = await _announcementController.fetchAnnouncements();
      setState(() {
        announcements = fetchedAnnouncements;
      });
    } catch (e) {
      // Handle error
      throw 'An error occurred while fetching announcements.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final BarangayModel args = ModalRoute.of(context)?.settings.arguments as BarangayModel;
    String brgyName = args.name;
    int brgyCode = args.code;

    return Scaffold(
      appBar: const EBAppBar(),
      drawer: const EBDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(createRoute(route: Routes.createAnnouncement)),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
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
                CardHeader(
                  barangayName: brgyName,
                  barangayCode: brgyCode.toString(),
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
    );
  }
}

/*
card header doesn't belong in scrolling

import 'dart:math';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/anct_controller.dart';
import 'package:ebayan/data/model/announcement_model.dart';
import 'package:ebayan/data/model/barangay_model.dart';
import 'package:ebayan/presentation/dashboard/announcements/widgets/announcement_card.dart';
import 'package:ebayan/presentation/dashboard/announcements/widgets/card_header.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';

class AnnouncementListScreen extends StatefulWidget {
  const AnnouncementListScreen({super.key});

  @override
  State<AnnouncementListScreen> createState() => _AnnouncementListScreenState();
}

class _AnnouncementListScreenState extends State<AnnouncementListScreen> {
  final Logger log = Logger();
  final AnnouncementController _announcementController = AnnouncementController();
  List<AnnouncementModel> announcements = [];

  @override
  void initState() {
    super.initState();
    _fetchAnnouncements();
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

  @override
  Widget build(BuildContext context) {
    final BarangayModel args = ModalRoute.of(context)?.settings.arguments as BarangayModel;
    String brgyName = args.name;
    int brgyCode = args.code;

    return Scaffold(
      appBar: const EBAppBar(),
      drawer: const EBDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(createRoute(route: Routes.createAnnouncement)),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Column(
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
                CardHeader(
                  barangayName: brgyName,
                  barangayCode: brgyCode.toString(),
                ),
                const SizedBox(height: Spacing.md),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: announcements.length,
                itemBuilder: (context, index) {
                  return AnnouncementCard(
                    announcement: announcements[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 */ 