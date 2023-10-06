import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EBFooter extends StatelessWidget {
  const EBFooter({super.key});

  @override
  Widget build(BuildContext context) {
    const double footerHeight = 50.0;
    const double paddingX = 50.0;
    const double paddingY = 15.0;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: EBColor.dark.withOpacity(0.1),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: paddingX, vertical: paddingY),
        child: SizedBox(
          height: footerHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SvgPicture.asset(Asset.companyPath),
                  EBTypography.small(
                    text: 'Copyright © ${DateTime.now().year}',
                    muted: true,
                  ),
                ],
              ),
              Column(
                children: [
                  SvgPicture.asset(Asset.logoColorPath),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
