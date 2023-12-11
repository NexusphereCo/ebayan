import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/constants/typography.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EBCircularLoadingIndicator extends StatelessWidget {
  final double? height;
  final bool? showText;

  final Color? strokeColor;

  const EBCircularLoadingIndicator({
    super.key,
    this.height,
    this.showText,
    this.strokeColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? MediaQuery.of(context).size.height * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(
              color: strokeColor ?? EBColor.primary,
              strokeCap: StrokeCap.round,
            ),
          ),
          (showText != null)
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: Spacing.md),
                    EBTypography.text(
                      text: 'Loading...',
                      color: EBColor.primary,
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}

class EBCustomLoadingScreen extends StatefulWidget {
  /// this refers to the opacity of the loading background
  /// by default the background has 50% opacity
  /// by setting this 'true' the background will be 100%
  final bool? solid;

  const EBCustomLoadingScreen({
    super.key,
    this.solid,
  });

  @override
  State<EBCustomLoadingScreen> createState() => _EBCustomLoadingScreenState();

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

class _EBCustomLoadingScreenState extends State<EBCustomLoadingScreen> {
  double currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (widget.solid ?? false) ? EBColor.light : Colors.transparent,
      body: Center(
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
      ),
    );
  }
}
