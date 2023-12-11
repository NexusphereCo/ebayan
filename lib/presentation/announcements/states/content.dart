import 'package:ebayan/data/viewmodel/barangay_view_model.dart';
import 'package:ebayan/presentation/announcements/widgets/announcement_card.dart';
import 'package:ebayan/presentation/announcements/widgets/heading.dart';
import 'package:ebayan/widgets/utils/fade_in.dart';

import 'package:flutter/material.dart';

class RenderAnnouncements extends StatelessWidget {
  final int index;

  const RenderAnnouncements({
    super.key,
    required this.barangay,
    required this.index,
  });

  final BarangayViewModel barangay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (index == 0) buildHeading(barangay: barangay),
        FadeIn(
          child: AnnouncementCard(announcement: barangay.announcements![index]),
        ),
      ],
    );
  }
}
