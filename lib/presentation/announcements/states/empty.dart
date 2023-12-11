import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/data/viewmodel/barangay_view_model.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/heading.dart';

class EmptyAnnouncements extends StatelessWidget {
  final BarangayViewModel barangay;

  const EmptyAnnouncements({
    super.key,
    required this.barangay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildHeading(barangay: barangay),
        const SizedBox(height: Spacing.xl),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(Asset.noAnnouncements),
                EBTypography.h2(text: 'No Announcements'),
                const SizedBox(height: Spacing.sm),
                EBTypography.label(
                  text: 'Check back again later!',
                  muted: true,
                  fontWeight: EBFontWeight.regular,
                ),
                const SizedBox(height: Spacing.lg),
                EBButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  text: 'Go Back',
                  theme: EBButtonTheme.primaryOutlined,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
