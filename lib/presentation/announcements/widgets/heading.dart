import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/data/viewmodel/barangay_view_model.dart';
import 'package:ebayan/presentation/dashboard/widgets/card_sphere.dart';
import 'package:ebayan/presentation/dashboard/widgets/loading_bar.dart';
import 'package:ebayan/widgets/utils/rotate_widget.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget buildHeading({required BarangayViewModel barangay}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          EBTypography.h1(text: 'Announcement'),
          const SizedBox(width: Spacing.sm),
          RotateWidget(
            degree: -15,
            child: FaIcon(
              FontAwesomeIcons.bullhorn,
              size: 30,
              color: EBColor.dark,
            ),
          ),
        ],
      ),
      const SizedBox(height: Spacing.md),
      ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        child: SphereCard(
          brgyName: barangay.name,
          municipalityName: barangay.municipality,
          brgyCode: barangay.code.toString(),
        ).cardHeader(),
      ),
      const SizedBox(height: Spacing.md),
    ],
  );
}

Widget buildLoadingHeading() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          EBLoadingBar(width: 200, height: 30, colors: [EBColor.primary[100]!, EBColor.primary[50]!.withOpacity(0.5)]),
        ],
      ),
      const SizedBox(height: Spacing.md),
      ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        child: const SphereCard(
          isLoading: true,
        ).cardHeader(),
      ),
      const SizedBox(height: Spacing.md),
    ],
  );
}
