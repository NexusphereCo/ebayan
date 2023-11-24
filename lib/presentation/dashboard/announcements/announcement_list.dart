import 'dart:math';
import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/anct_controller.dart';
import 'package:ebayan/data/model/announcement_model.dart';
import 'package:ebayan/data/viewmodel/announcement_view_model.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';

class AnnouncementListScreen extends StatefulWidget {
  final Logger log = Logger();
  final String brgyName;
  final String brgyCode;

  AnnouncementListScreen({
    Key? key,
    required this.brgyName,
    required this.brgyCode,
  }) : super(key: key);

  @override
  State<AnnouncementListScreen> createState() => _AnnouncementListScreenState();
}

class _AnnouncementListScreenState extends State<AnnouncementListScreen> {
  final AnnouncementController _announcementController = AnnouncementController();
  List<AnnouncementModel> announcements = [];
  final Logger log = Logger();

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
    return Scaffold(
      appBar: const EBAppBar(),
      drawer: const EBDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(createRoute(route: '/dashboard/create_announcement')),
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
                // Use _cardHeader method from SphereCard
                CardHeader(
                  barangayName: widget.brgyName,
                  barangayCode: widget.brgyCode,
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

class AnnouncementCard extends StatelessWidget {
  final AnnouncementModel announcement;

  const AnnouncementCard({
    Key? key,
    required this.announcement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 125,
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: EBColor.primary.shade200,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EBTypography.h4(
                      text: announcement.heading,
                      color: EBColor.primary,
                      fontWeight: FontWeight.bold,
                      cutOverflow: true,
                      maxLines: 3,
                    ),
                    EBTypography.small(text: announcement.timeCreated.toString(), color: EBColor.dark, fontWeight: EBFontWeight.regular),
                  ],
                ),
              ),
              const SizedBox(width: Spacing.lg),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EBButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.announcement, arguments: announcement.id);
                    },
                    text: 'View',
                    theme: EBButtonTheme.primary,
                    size: EBButtonSize.md,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardHeader extends StatelessWidget {
  final String barangayName;
  final String barangayCode;

  const CardHeader({Key? key, required this.barangayName, required this.barangayCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: EBColor.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      height: 110,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                EBTypography.h4(
                  text: barangayName,
                  color: EBColor.light,
                  maxLines: 2,
                ),
                EBTypography.small(text: barangayCode, color: EBColor.light),
                const SizedBox(height: Spacing.md),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(Asset.illustHousePath, fit: BoxFit.fitHeight),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
