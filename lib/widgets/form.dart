import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EBTextField extends StatelessWidget {
  final String placeholder;
  final TextInputType type;

  final int? maxLength;
  final bool? obscureText;
  final Icon? suffixIcon;
  final IconButton? suffixIconButton;
  final String? Function(String?)? validator;

  const EBTextField({
    super.key,
    required this.placeholder,
    required this.type,
    this.obscureText,
    this.suffixIcon,
    this.suffixIconButton,
    this.maxLength,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    const borderRadius = 8.0;

    return TextFormField(
      keyboardType: TextInputType.text,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        hintText: placeholder,
        counterText: null,
        suffixIcon: (suffixIcon == null ? false : true) ? suffixIcon : suffixIconButton,
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
      fieldWidth: 50,
    );

    const double textFieldGap = 0;
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
  final IconData icon;
  final EBTextField textField;

  const EBTextBox({
    super.key,
    required this.label,
    required this.icon,
    required this.textField,
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EBTypography.label(text: label, muted: true),
              const SizedBox(height: Spacing.formSm),
              textField,
            ],
          ),
        ),
      ],
    );
  }
}
