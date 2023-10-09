import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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
  final String theme;
  final VoidCallback onPressed;

  // styling
  final double _borderRadius = 50.0;
  final double _paddingX = 32.0;
  final double _paddingY = 18.0;

  const EBButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ButtonStyle fillButtonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      padding: EdgeInsets.symmetric(horizontal: _paddingX, vertical: _paddingY),
      elevation: 0,
      backgroundColor: _setColor(theme),
    );

    ButtonStyle outlineButtonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        side: BorderSide(color: _setColor(theme)),
      ),
      backgroundColor: EBColor.light,
      padding: EdgeInsets.symmetric(
        horizontal: _paddingX,
        vertical: _paddingY,
      ),
      elevation: 0,
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: !theme.contains('outline') ? fillButtonStyle : outlineButtonStyle,
      child: EBTypography.text(
        text: text,
        color: theme.contains('outline') ? _setColor(theme) : EBColor.light,
      ),
    );
  }

  Color _setColor(String theme) {
    switch (theme) {
      case 'primary' || 'primary-outline':
        return EBColor.primary;
      case 'dark' || 'dark-outline':
        return EBColor.dark;
      case 'light':
        return EBColor.light;
      case 'warning':
        return EBColor.warning;
      case 'danger':
        return EBColor.danger;
      default:
        return EBColor.dark;
    }
  }
}
