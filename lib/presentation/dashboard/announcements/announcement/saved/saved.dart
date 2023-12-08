import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/anct_controller.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/data/model/announcement_model.dart';
import 'package:ebayan/presentation/dashboard/announcements/widgets/announcement_card.dart';
import 'package:ebayan/utils/global.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SavedAnnouncementScreen extends StatefulWidget {
  const SavedAnnouncementScreen({super.key});

  @override
  State<SavedAnnouncementScreen> createState() => _SavedAnnouncementScreenState();
}

class _SavedAnnouncementScreenState extends State<SavedAnnouncementScreen> {
  final AnnouncementController announcementController = AnnouncementController();
  final UserController userController = UserController();
  late Future<List<AnnouncementModel>> savedAnnouncements;

  final EBLoadingScreen loadingScreen = const EBLoadingScreen();

  @override
  void initState() {
    super.initState();
    connectionHandler(context);
    savedAnnouncements = _fetchSavedAnnouncements();
  }

  Future<List<AnnouncementModel>> _fetchSavedAnnouncements() async {
    try {
      final List<String> savedAnnouncementIds = await userController.getSavedAnnouncements();
      final List<AnnouncementModel> allAnnouncements = await announcementController.fetchAnnouncements();

      final List<AnnouncementModel> savedAnnouncements = allAnnouncements.where((announcement) => savedAnnouncementIds.contains(announcement.id)).toList();

      return savedAnnouncements;
    } catch (e) {
      throw 'An error occurred while fetching saved announcements.';
    }
  }

  Future<void> _refresh() async {
    setState(() {
      savedAnnouncements = _fetchSavedAnnouncements();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AnnouncementModel>>(
      future: savedAnnouncements,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const EBLoadingScreen(
            solid: true,
          );
        } else {
          final List<AnnouncementModel> data = snapshot.data!;
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
                itemCount: data.length + 1,
                itemBuilder: (context, index) {
                  final dataIndex = index - 1;
                  if (index == 0) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            EBTypography.h1(text: 'Saved Announcement'),
                            const SizedBox(width: Spacing.sm),
                            FaIcon(
                              FontAwesomeIcons.solidBookmark,
                              size: 25,
                              color: EBColor.primary,
                            ),
                          ],
                        ),
                        const SizedBox(height: Spacing.lg),
                      ],
                    );
                  } else {
                    return AnnouncementCard(
                      announcement: data[dataIndex],
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
