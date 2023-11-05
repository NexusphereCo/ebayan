import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EBLoadingScreen extends StatefulWidget {
  /// this refers to the opacity of the loading background
  /// by default the background has 50% opacity
  /// by setting this 'true' the background will be 100%
  final bool? solid;

  const EBLoadingScreen({
    Key? key,
    this.solid,
  }) : super(key: key);

  @override
  State<EBLoadingScreen> createState() => _EBLoadingScreenState();

  void show(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
        return this;
      },
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: EBColor.light.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
          child: child,
        );
      },
    );
  }

  void hide(BuildContext context) {
    Navigator.of(context).pop();
  }
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
          // Cycle through 0, 1, 2
          currentPage = (currentPage + 1) % 3;
          // Start the animation again
          _startDotsAnimation();
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
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(Asset.lottieLoadingLogo),
          Text(
            'Loading...',
            style: TextStyle(
              fontFamily: EBTypography.fontFamily,
              color: EBColor.primary,
              decoration: TextDecoration.none,
              fontSize: EBFontSize.normal,
              fontWeight: EBFontWeight.regular,
            ),
          ),
        ],
      ),
    );
  }
}
