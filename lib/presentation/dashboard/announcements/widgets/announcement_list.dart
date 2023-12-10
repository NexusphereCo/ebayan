import 'package:ebayan/data/model/announcement_model.dart';
import 'package:ebayan/presentation/dashboard/announcements/widgets/announcement_card.dart';
import 'package:flutter/material.dart';

class AnnouncementList extends StatelessWidget {
  final List<AnnouncementModel> announcements;

  const AnnouncementList({super.key, required this.announcements});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final announcement = announcements[index];
          return AnnouncementCard(
            announcement: announcement,
          );
        },
        childCount: announcements.length,
      ),
    );
  }
}
