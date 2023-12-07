import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EBFooter extends StatelessWidget {
  const EBFooter({super.key});

  final double _footerHeight = 50.0;
  final double _paddingX = 50.0;
  final double _paddingY = 15.0;

  @override
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.symmetric(horizontal: _paddingX, vertical: _paddingY),
        child: SizedBox(
          height: _footerHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SvgPicture.asset(Asset.logoCompany),
                  EBTypography.small(
                    text: 'Copyright © ${DateTime.now().year}',
                    muted: true,
                  ),
                ],
              ),
              Column(
                children: [
                  SvgPicture.asset(Asset.logoWColor),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
