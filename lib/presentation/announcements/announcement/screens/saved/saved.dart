import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/anct_controller.dart';
import 'package:ebayan/controller/brgy_controller.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/data/viewmodel/announcement_view_model.dart';
import 'package:ebayan/presentation/announcements/announcement/screens/saved/states/content.dart';
import 'package:ebayan/presentation/announcements/announcement/screens/saved/states/empty.dart';
import 'package:ebayan/utils/global.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/layout_components/appbar_bottom.dart';
import 'package:ebayan/widgets/layout_components/appbar_top.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SavedAnnouncementScreen extends StatefulWidget {
  const SavedAnnouncementScreen({super.key});

  @override
  State<SavedAnnouncementScreen> createState() => _SavedAnnouncementScreenState();
}

class _SavedAnnouncementScreenState extends State<SavedAnnouncementScreen> {
  // Controllers
  final AnnouncementController announcementController = AnnouncementController();
  final BarangayController brgyController = BarangayController();
  final UserController userController = UserController();

  @override
  void initState() {
    connectionHandler(context);
    super.initState();
  }

  Future<List<AnnouncementViewModel>> fetchSavedAnnouncements() async {
    return await userController.getSavedAnnouncements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBAppBar(enablePop: true),
      drawer: const EBDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(Global.paddingBody),
        child: FutureBuilder(
          future: fetchSavedAnnouncements(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      EBTypography.h1(text: 'Saved Announcements'),
                      const SizedBox(width: Spacing.sm),
                      FaIcon(FontAwesomeIcons.solidBookmark, size: 30, color: EBColor.dark),
                    ],
                  ),
                  const SizedBox(height: Spacing.md),
                  const EBCircularLoadingIndicator(showText: true),
                ],
              );
            } else {
              final List<AnnouncementViewModel> announcements = snapshot.data!;

              return RefreshIndicator(
                onRefresh: () async => setState(() {}),
                backgroundColor: EBColor.primary,
                color: EBColor.light,
                child: ListView.builder(
                  itemCount: announcements.isEmpty ? 1 : announcements.length,
                  itemBuilder: (context, index) {
                    return announcements.isEmpty //
                        ? const EmptySavedAnnouncements()
                        : RenderSavedAnnouncements(
                            announcements: announcements,
                            index: index,
                          );
                  },
                ),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: const EBAppBarBottom(activeIndex: 3),
    );
  }
}
