import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EBTextField extends StatelessWidget {
  final String label;
  final TextInputType type;

  final String? value;
  final TextEditingController? controller;
  final int? maxLength;
  final bool? enabled;
  final bool? readOnly;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? suffixIconButton;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final bool? isDense;
  final int? maxLines;
  final String? placeholder;

  const EBTextField({
    super.key,
    required this.label,
    required this.type,
    this.value,
    this.obscureText,
    this.suffixIcon,
    this.suffixIconButton,
    this.maxLength,
    this.validator,
    this.enabled,
    this.controller,
    this.readOnly,
    this.onTap,
    this.inputFormatters,
    this.focusNode,
    this.isDense,
    this.maxLines,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    const borderRadius = 8.0;

    return TextFormField(
      style: const TextStyle(fontSize: EBFontSize.normal),
      onTap: onTap,
      enabled: enabled,
      keyboardType: type,
      controller: controller,
      obscureText: obscureText ?? false,
      readOnly: readOnly ?? false,
      inputFormatters: inputFormatters,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: placeholder,
        filled: true,
        fillColor: (!(enabled ?? true)) ? EBColor.primary[50] : Colors.transparent,
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
        floatingLabelBehavior: (placeholder != null) ? FloatingLabelBehavior.always : FloatingLabelBehavior.auto,
        counterText: '',
        suffixIcon: suffixIcon ?? suffixIconButton,
        isDense: isDense,
      ),
      maxLength: maxLength,
      maxLines: maxLines,
      validator: validator,

      /// This is to modify the text to make it so that they are
      /// all uppercase...

      /* onChanged: (value) {
       *   controller?.value = TextEditingValue(
       *     text: value.toLowerCase(),
       *     selection: controller!.selection,
       *   );
       * },
       */
    );
  }
}

class EBTextBox extends StatelessWidget {
  final IconData icon;
  final Widget textField;

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
