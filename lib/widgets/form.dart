import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
          EBTypography.label(
            text: widget._label,
            muted: true,
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

class MultiTextField extends StatefulWidget {
  final void Function(String) onCompleted;
  final void Function(String) onChanged;

  const MultiTextField({super.key, required this.onCompleted, required this.onChanged});

  @override
  State<StatefulWidget> createState() => _MultiTextFieldState();
}

class _MultiTextFieldState extends State<MultiTextField> {
  @override
  Widget build(BuildContext context) {
    PinTheme pinTheme = PinTheme(
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(6.0),
      inactiveColor: EBColor.primary,
      activeColor: EBColor.primary,
      selectedColor: EBColor.primary,
      errorBorderColor: EBColor.danger,
      inactiveBorderWidth: 1,
      activeBorderWidth: 1,
      selectedBorderWidth: 3,
      fieldHeight: 40.0,
    );

    const double textFieldGap = 50.0;
    const int textFieldLength = 6;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: textFieldGap),
      child: PinCodeTextField(
        pinTheme: pinTheme,
        textStyle: const TextStyle(
          color: EBColor.primary,
          fontWeight: EBFontWeight.regular,
          fontSize: 15,
        ),
        hintStyle: TextStyle(
          color: EBColor.primary.withOpacity(0.5),
          fontWeight: EBFontWeight.regular,
          fontSize: 15,
        ),
        hintCharacter: '-',
        length: textFieldLength,
        cursorWidth: 2,
        showCursor: true,
        animationType: AnimationType.scale,
        keyboardType: TextInputType.number,
        appContext: context,
        onCompleted: widget.onCompleted,
        onChanged: widget.onChanged,
      ),
    );
  }
}

class EBTextBox extends StatelessWidget {
  final String label;
  final String type; // text, password, date, number, ... etc.
  final IconData icon;
  final IconData? suffixIcon;
  final void Function()? suffixIconOnPressed;
  final String? placeholder;

  const EBTextBox({
    super.key,
    required this.label,
    required this.type,
    required this.icon,
    this.suffixIcon,
    this.suffixIconOnPressed,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            const SizedBox(height: Spacing.formMd),
            Icon(
              icon,
              color: EBColor.primary,
            ),
          ],
        ),
        const SizedBox(width: Spacing.formMd),
        EBTextField(
          label: label,
          type: type,
          placeholder: placeholder,
          suffixIcon: suffixIcon,
          suffixIconOnPressed: suffixIconOnPressed,
        ),
      ],
    );
  }
}
