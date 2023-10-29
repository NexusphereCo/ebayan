import 'package:dots_indicator/dots_indicator.dart';
import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EBLoadingScreen extends StatefulWidget {
  const EBLoadingScreen({Key? key}) : super(key: key);

  @override
  State<EBLoadingScreen> createState() => _EBLoadingScreenState();
}

class _EBLoadingScreenState extends State<EBLoadingScreen> {
  double currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startDotsAnimation();
  }

  void _startDotsAnimation() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          currentPage = (currentPage + 1) % 3; // Cycle through 0, 1, 2
          _startDotsAnimation(); // Start the animation again
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

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
            DotsIndicator(
              dotsCount: 3,
              position: currentPage,
              decorator: DotsDecorator(
                size: const Size.square(10),
                activeSize: const Size.square(10),
                color: EBColor.primary[300]!,
                activeColor: EBColor.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
