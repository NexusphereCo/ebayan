import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EBLoadingScreen extends StatelessWidget {
  const EBLoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: EBColor.light.withOpacity(0.5),
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(Asset.lottieLoadingLogo),
            EBTypography.label(text: 'Loading...'),
          ],
        ),
      ),
    );
  }
}
