import 'dart:math';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/anct_controller.dart';
import 'package:ebayan/data/model/announcement_model.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnnouncementListScreen extends StatefulWidget {
  const AnnouncementListScreen({Key? key}) : super(key: key);

  @override
  State<AnnouncementListScreen> createState() => _AnnouncementListScreenState();
}

class _AnnouncementListScreenState extends State<AnnouncementListScreen> {
  final AnnouncementController _announcementController = AnnouncementController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBAppBar(),
      drawer: const EBDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(createRoute(route: '/dashboard/create_announcement')),
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _announcementController.fetchAnnouncements(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(24.0),
              itemCount: snapshot.data!.length + 1,
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
                      const SphereInfoCard(),
                      const SizedBox(height: Spacing.md),
                      Divider(
                        color: EBColor.primary,
                        height: 25,
                        thickness: 1.5,
                        indent: 5,
                        endIndent: 5,
                      ),
                      const SizedBox(height: Spacing.md),
                    ],
                  );
                } else {
                  AnnouncementModel announcement = AnnouncementModel.fromMap(snapshot.data![dataIndex]);
                  return AnnouncementCard(
                    heading: announcement.heading,
                    body: announcement.body,
                    announcementId: snapshot.data![dataIndex]['id'],
                    onViewPressed: () {
                      Navigator.of(context).push(createRoute(route: '/dashboard/announcements/${snapshot.data![dataIndex]['id']}'));
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}

class AnnouncementCard extends StatelessWidget {
  final String heading;
  final String body;
  final String announcementId;
  final VoidCallback onViewPressed;

  const AnnouncementCard({
    Key? key,
    required this.heading,
    required this.body,
    required this.announcementId,
    required this.onViewPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 125,
      margin: const EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
        color: EBColor.primary.shade200,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          width: 2,
          color: EBColor.primary,
        ),
      ),
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                      text: heading,
                      color: EBColor.primary,
                      cutOverflow: true,
                      maxLines: 3,
                    ),
                    EBTypography.small(text: 'September 10, 2034', color: EBColor.dark, muted: true),
                  ],
                ),
              ),
              const SizedBox(width: Spacing.lg),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EBButton(
                    onPressed: onViewPressed,
                    text: 'View',
                    theme: EBButtonTheme.primary,
                    size: EBButtonSize.sm,
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

class SphereInfoCard extends StatelessWidget {
  const SphereInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 117,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: EBColor.primary.shade200,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          width: 2,
          color: EBColor.primary,
        ),
      ),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EBTypography.h4(text: 'San Felipe, Naga City', color: EBColor.dark),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        IconButton(
                          padding: const EdgeInsets.only(right: 5.0),
                          icon: const Icon(FeatherIcons.copy),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        EBTypography.text(text: 'BSF-09124A', color: EBColor.dark),
                        EBTypography.small(text: 'Copy this code', color: EBColor.dark),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        EBTypography.small(text: '42', color: EBColor.primary),
                        const SizedBox(width: 5),
                        Icon(
                          FeatherIcons.user,
                          size: 20,
                          color: EBColor.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
