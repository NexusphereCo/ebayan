import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

enum EBButtonTheme {
  primary,
  primaryOutlined,
  secondary,
  secondaryOutlined,
  warning,
  warningOutlined,
  danger,
  dangerOutlined,
  light,
  lightOutlined,
  dark,
  darkOutlined,
}

class EBBackButton extends StatelessWidget {
  final Widget screenDestination;

  const EBBackButton({
    super.key,
    required this.screenDestination,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          color: EBColor.primary,
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: screenDestination,
              ),
            );
          },
          icon: const Icon(FeatherIcons.arrowLeft),
        ),
      ],
    );
  }
}

class EBButton extends StatelessWidget {
  final String text;
  final EBButtonTheme theme;
  final VoidCallback onPressed;

  // Array of themes in their categories
  final defaultThemes = {
    EBButtonTheme.primary,
    EBButtonTheme.secondary,
    EBButtonTheme.warning,
    EBButtonTheme.danger,
    EBButtonTheme.light,
    EBButtonTheme.dark,
  };
  final outlineThemes = {
    EBButtonTheme.primaryOutlined,
    EBButtonTheme.secondaryOutlined,
    EBButtonTheme.warningOutlined,
    EBButtonTheme.dangerOutlined,
    EBButtonTheme.lightOutlined,
    EBButtonTheme.darkOutlined,
  };

  // styling
  final double _borderRadius = 50.0;
  final double _paddingX = 32.0;
  final double _paddingY = 18.0;

  EBButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ButtonStyleButton button;

    final btnPadding = EdgeInsets.symmetric(horizontal: _paddingX, vertical: _paddingY);
    final btnShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadius));

    // regular button
    if (defaultThemes.contains(theme)) {
      // apply the default styles
      button = ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: btnShape,
          padding: btnPadding,
          elevation: 0,
          backgroundColor: _setColor(theme),
        ),
        child: EBTypography.text(
          text: text,
          color: EBColor.light,
        ),
      );
    }
    // outlined button
    else {
      // apply the outline button styles
      button = OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: _setColor(theme)),
          shape: btnShape,
          foregroundColor: _setColor(theme),
          backgroundColor: Colors.transparent,
          padding: btnPadding,
          elevation: 0,
        ),
        child: EBTypography.text(
          text: text,
          color: _setColor(theme),
        ),
      );
    }
    return button;
  }

  Color _setColor(EBButtonTheme theme) {
    switch (theme) {
      case EBButtonTheme.primary || EBButtonTheme.primaryOutlined:
        return EBColor.primary;
      case EBButtonTheme.dark || EBButtonTheme.darkOutlined:
        return EBColor.dark;
      case EBButtonTheme.light || EBButtonTheme.lightOutlined:
        return EBColor.light;
      case EBButtonTheme.warning || EBButtonTheme.warningOutlined:
        return EBColor.warning;
      case EBButtonTheme.danger || EBButtonTheme.dangerOutlined:
        return EBColor.danger;
      default:
        return EBColor.dark;
    }
  }
}
