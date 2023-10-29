import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EBTextField extends StatelessWidget {
  final String label;
  final TextInputType type;

  final TextEditingController? controller;
  final int? maxLength;
  final bool? enabled;
  final bool? obscureText;
  final Icon? suffixIcon;
  final IconButton? suffixIconButton;
  final String? Function(String?)? validator;

  const EBTextField({
    super.key,
    required this.label,
    required this.type,
    this.obscureText,
    this.suffixIcon,
    this.suffixIconButton,
    this.maxLength,
    this.validator,
    this.enabled,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    const borderRadius = 8.0;

    return TextFormField(
      enabled: enabled,
      keyboardType: TextInputType.text,
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        filled: true,
        fillColor: (!(enabled ?? true)) ? EBColor.primary[100] : Colors.transparent,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: EBColor.dark.withOpacity(0.5), width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        label: Text(
          label,
          style: const TextStyle(fontSize: EBFontSize.normal),
        ),
        counterText: null,
        suffixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: (suffixIcon == null ? false : true) ? suffixIcon : suffixIconButton,
        ),
      ),
      maxLength: maxLength,
      validator: validator,
    );
  }
}

class MultiTextField extends StatefulWidget {
  final void Function(String) onCompleted;
  final void Function(String) onChanged;

  const MultiTextField({
    super.key,
    required this.onCompleted,
    required this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _MultiTextFieldState();
}

class _MultiTextFieldState extends State<MultiTextField> {
  @override
  Widget build(BuildContext context) {
    var fieldWidth = MediaQuery.of(context).size.width / 8;
    var fieldWidthMax = 50.0;

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
      fieldHeight: 50.0,
      fieldWidth: (fieldWidth >= fieldWidthMax) ? fieldWidthMax : fieldWidth,
    );

    const int textFieldLength = 5;

    return PinCodeTextField(
      pinTheme: pinTheme,
      textStyle: TextStyle(
        color: EBColor.primary,
        fontWeight: EBFontWeight.regular,
        fontSize: EBFontSize.label,
      ),
      hintStyle: TextStyle(
        color: EBColor.primary.withOpacity(0.5),
        fontWeight: EBFontWeight.regular,
        fontSize: EBFontSize.label,
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
    );
  }
}

class EBTextBox extends StatelessWidget {
  final IconData icon;
  final EBTextField textField;

  const EBTextBox({
    super.key,
    required this.icon,
    required this.textField,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: EBColor.primary,
        ),
        const SizedBox(width: Spacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Spacing.sm),
              textField,
            ],
          ),
        ),
      ],
    );
  }
}
