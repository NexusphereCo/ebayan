import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/constants/typography.dart';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

enum TailPosition { topLeft, topCenter, topRight, bottomLeft, bottomCenter, bottomRight }

Widget guideCard({
  required String heading,
  required String description,
  required void Function() onNext,
  void Function()? onPrev,
  void Function()? onSkip,
  // variables
  required int currentStep,
  required TailPosition tailPosition,
}) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.lg, vertical: Spacing.md),
        decoration: BoxDecoration(
          color: EBColor.light,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EBTypography.h4(text: heading),
                (onSkip != null)
                    ? TextButton(
                        onPressed: onSkip,
                        child: EBTypography.text(text: 'Skip Tutorial', color: EBColor.green),
                      )
                    : Container(),
              ],
            ),
            const SizedBox(height: Spacing.sm),
            EBTypography.text(text: description),
            const SizedBox(height: Spacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    4,
                    (index) => Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: (currentStep == index + 1) ? EBColor.primary : EBColor.primary.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      margin: const EdgeInsets.all(4.0),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    (onPrev != null)
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: EBColor.primary, width: 1),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              iconSize: EBFontSize.normal,
                              icon: Icon(FeatherIcons.arrowLeft, color: EBColor.primary),
                              onPressed: onPrev,
                            ),
                          )
                        : Container(),
                    const SizedBox(width: Spacing.sm),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: EBColor.primary, width: 1),
                        shape: BoxShape.circle,
                        color: EBColor.primary,
                      ),
                      child: IconButton(
                        iconSize: EBFontSize.normal,
                        icon: Icon(FeatherIcons.arrowRight, color: EBColor.light),
                        onPressed: onNext,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: Spacing.sm),
          ],
        ),
      ),
      Positioned(
        left: 0,
        top: 0,
        bottom: 0,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
          ),
          child: Container(
            width: 10,
            color: EBColor.primary,
          ),
        ),
      ),
      // set the position for the tail
      switch (tailPosition) {
        TailPosition.topLeft => Positioned(top: -10, left: 10, child: SvgPicture.asset(Asset.cardTailUp)),
        TailPosition.topCenter => Positioned(top: -10, left: 10, right: 10, child: SvgPicture.asset(Asset.cardTailUp)),
        TailPosition.topRight => Positioned(top: -10, right: 10, child: SvgPicture.asset(Asset.cardTailUp)),
        // bottom
        TailPosition.bottomLeft => Positioned(bottom: -10, left: 10, child: SvgPicture.asset(Asset.cardTailDown)),
        TailPosition.bottomCenter => Positioned(bottom: -10, left: 10, right: 10, child: SvgPicture.asset(Asset.cardTailDown)),
        TailPosition.bottomRight => Positioned(bottom: -10, right: 10, child: SvgPicture.asset(Asset.cardTailDown)),
      }
    ],
  );
}
