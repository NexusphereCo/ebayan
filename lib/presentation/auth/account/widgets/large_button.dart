import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/style.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class LargeCustomButton extends StatelessWidget {
  final String heading;
  final String lead;
  final Icon? icon;
  final void Function()? onTap;

  const LargeCustomButton({
    super.key,
    required this.heading,
    required this.lead,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: EBColor.green[300],
        borderRadius: BorderRadius.circular(EBBorderRadius.md),
        child: Ink(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(EBBorderRadius.md),
            color: EBColor.green,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon ?? Container(),
                  const SizedBox(width: Spacing.md),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EBTypography.h4(text: heading, color: EBColor.light),
                      EBTypography.small(text: lead, color: EBColor.light, fontWeight: EBFontWeight.thin),
                    ],
                  ),
                ],
              ),
              Icon(FeatherIcons.arrowRight, color: EBColor.light),
            ],
          ),
        ),
      ),
    );
  }
}
