import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

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

enum EBButtonSize {
  lg,
  md,
  sm,
}

class EBBackButton extends StatelessWidget {
  const EBBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          color: EBColor.primary,
          onPressed: () {
            Navigator.of(context).pop();
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

  final Icon? icon;
  final EBButtonSize? size;

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

  EBButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.theme,
    this.icon,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ButtonStyleButton button;
    double paddingX = 32.0;
    double paddingY = 18.0;

    // if the size is specified
    switch (size ?? EBButtonSize.md) {
      case EBButtonSize.sm:
        paddingX = 15.0;
        paddingY = 10.0;
        break;
      case EBButtonSize.md:
        paddingX = 24.0;
        paddingY = 15.0;
        break;
      case EBButtonSize.lg:
        paddingX = 32.0;
        paddingY = 18.0;
        break;
    }

    final btnPadding = EdgeInsets.symmetric(horizontal: paddingX, vertical: paddingY);
    final btnShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadius));
    const textIconSpacing = 6.0;

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
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: textIconSpacing,
          children: [
            switch (size ?? EBButtonSize.md) {
              EBButtonSize.sm => EBTypography.small(
                  text: text,
                  color: EBColor.light,
                ),
              EBButtonSize.md => EBTypography.text(
                  text: text,
                  color: EBColor.light,
                ),
              EBButtonSize.lg => EBTypography.h3(
                  text: text,
                  color: EBColor.light,
                  fontWeight: EBFontWeight.regular,
                ),
            },
            if (icon != null) Container(child: icon),
          ],
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
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: textIconSpacing,
          children: [
            switch (size ?? EBButtonSize.md) {
              EBButtonSize.sm => EBTypography.small(
                  text: text,
                  color: _setColor(theme),
                ),
              EBButtonSize.md => EBTypography.text(
                  text: text,
                  color: _setColor(theme),
                ),
              EBButtonSize.lg => EBTypography.h3(
                  text: text,
                  color: _setColor(theme),
                  fontWeight: EBFontWeight.regular,
                ),
            },
            if (icon != null) Container(child: icon),
          ],
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
        return EBColor.yellow;
      case EBButtonTheme.danger || EBButtonTheme.dangerOutlined:
        return EBColor.red;
      default:
        return EBColor.dark;
    }
  }
}
