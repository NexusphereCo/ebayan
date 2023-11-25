import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
