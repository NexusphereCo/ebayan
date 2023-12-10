import 'package:flutter/material.dart';

class FadeIn extends StatefulWidget {
  final Widget child;

  const FadeIn({
    super.key,
    required this.child,
  });

  @override
  State<FadeIn> createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  final int durationMs = 300;

  @override
  void initState() {
    super.initState();

    // Animation setup
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: durationMs),
    );

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(animationController);

    // Start the animation
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
