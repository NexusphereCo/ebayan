import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/utils/dimens.dart';
import 'package:flutter/material.dart';

class EBTextField extends StatefulWidget {
  final String _label;
  final String _type; // text, password, date, number, ... etc.
  final IconData? _suffixIcon;
  final void Function()? _suffixIconOnPressed;
  final String? _placeholder;

  // styling
  final double _paddingX = 15.0;
  final double _paddingY = 0;
  final double _borderRadius = 7.0;

  const EBTextField({
    Key? key,
    required String label,
    required String type,
    IconData? suffixIcon,
    void Function()? suffixIconOnPressed,
    String? placeholder,
  })  : _placeholder = placeholder,
        _suffixIcon = suffixIcon,
        _suffixIconOnPressed = suffixIconOnPressed,
        _type = type,
        _label = label,
        super(key: key);

  @override
  _EBTextFieldState createState() => _EBTextFieldState();
}

class _EBTextFieldState extends State<EBTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget._label,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: widget._paddingX, vertical: widget._paddingY),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget._borderRadius),
              border: Border.all(
                color: _isFocused ? EBColor.primary : EBColor.dark, // Change border color when focused
              ),
            ),
            child: Focus(
              onFocusChange: (hasFocus) {
                setState(() {
                  _isFocused = hasFocus;
                });
              },
              child: TextField(
                obscureText: (widget._type != 'password') ? false : true,
                decoration: InputDecoration(
                  hintText: widget._placeholder,
                  border: InputBorder.none,
                  suffixIcon: (widget._type == 'password' || widget._type == 'password-reveal')
                      ? IconButton(
                          icon: Icon(widget._suffixIcon),
                          onPressed: widget._suffixIconOnPressed,
                        )
                      : null,
                ),
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
        Column(
          children: [
            const SizedBox(height: Spacing.formMd),
            Icon(
              _icon,
              color: EBColor.primary,
            ),
          ],
        ),
        const SizedBox(width: Spacing.formMd),
        EBTextField(label: _label, type: _type, placeholder: _placeholder, suffixIcon: _suffixIcon, suffixIconOnPressed: _suffixIconOnPressed),
      ],
    );
  }
}
