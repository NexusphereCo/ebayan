import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:flutter/material.dart';

class EBButton extends StatelessWidget {
  final double _borderRadius = 50.0;
  final double _paddingX = 32.0;
  final double _paddingY = 15.0;
  final String _text;
  final VoidCallback _onPressed;
  final String _theme;

  const EBButton({Key? key, required void Function() onPressed, required String text, required String theme})
      : _onPressed = onPressed,
        _text = text,
        _theme = theme,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var fillButtonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      padding: EdgeInsets.symmetric(horizontal: _paddingX, vertical: _paddingY),
      elevation: 0,
      backgroundColor: _setColor(_theme),
    );

    var outlineButtonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        side: BorderSide(color: _setColor(_theme)),
      ),
      backgroundColor: EBColor.light,
      padding: EdgeInsets.symmetric(horizontal: _paddingX, vertical: _paddingY),
      elevation: 0,
    );

    return ElevatedButton(
      onPressed: _onPressed,
      style: !_theme.contains('outline') ? fillButtonStyle : outlineButtonStyle,
      child: EBTypography.p(text: _text, color: _theme.contains('outline') ? _setColor(_theme) : EBColor.light),
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
