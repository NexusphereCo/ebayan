import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/dimens.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class EBTextField extends StatelessWidget {
  final String _label;
  final String _type; // text, password, date, number, ... etc.
  final IconData? _suffixIcon;
  final void Function()? _suffixIconOnPressed;
  final String? _placeholder;

  // styling
  final double _paddingX = 15.0;
  final double _paddingY = 0;
  final double _borderRadius = 7.0;

  const EBTextField({super.key, required String label, required String type, IconData? suffixIcon, void Function()? suffixIconOnPressed, String? placeholder})
      : _placeholder = placeholder,
        _suffixIcon = suffixIcon,
        _suffixIconOnPressed = suffixIconOnPressed,
        _type = type,
        _label = label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EBTypography.label(text: _label, muted: true),
          const SizedBox(height: Spacing.label),
          Container(
            padding: EdgeInsets.symmetric(horizontal: _paddingX, vertical: _paddingY),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_borderRadius),
              border: Border.all(color: EBColor.dark),
            ),
            child: TextField(
              obscureText: (_type != 'password') ? false : true,
              decoration: InputDecoration(
                hintText: _placeholder,
                border: InputBorder.none,
                suffixIcon: (_type == 'password' || _type == 'password-reveal')
                    ? IconButton(
                        icon: Icon(_suffixIcon),
                        onPressed: _suffixIconOnPressed,
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EBTextBox extends StatelessWidget {
  final String _label;
  final String _type; // text, password, date, number, ... etc.
  final IconData _icon;
  final IconData? _suffixIcon;
  final void Function()? _suffixIconOnPressed;
  final String? _placeholder;

  const EBTextBox({super.key, String? placeholder, required String label, required IconData icon, required String type, IconData? suffixIcon, void Function()? suffixIconOnPressed})
      : _type = type,
        _icon = icon,
        _suffixIcon = suffixIcon,
        _suffixIconOnPressed = suffixIconOnPressed,
        _label = label,
        _placeholder = placeholder;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          _icon,
          color: EBColor.primary,
        ),
        const SizedBox(width: Spacing.formMd),
        EBTextField(label: _label, type: _type, placeholder: _placeholder, suffixIcon: _suffixIcon, suffixIconOnPressed: _suffixIconOnPressed),
      ],
    );
  }
}
