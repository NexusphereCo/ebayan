import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/style.dart';
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
  });

  @override
  Widget build(BuildContext context) {
    const borderRadius = 8.0;

    return TextFormField(
      onTap: onTap,
      enabled: enabled,
      keyboardType: type,
      controller: controller,
      obscureText: obscureText ?? false,
      readOnly: readOnly ?? false,
      inputFormatters: inputFormatters,
      focusNode: focusNode,
      decoration: InputDecoration(
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
        counterText: '',
        suffixIcon: suffixIcon ?? suffixIconButton,
        isDense: isDense,
      ),
      maxLength: maxLength,
      maxLines: maxLines,
      validator: validator,
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

/**
class EBDropdownButton extends StatefulWidget {
  final List<String> items;
  final String? selectedValue;

  const EBDropdownButton({
    Key? key, // Add the key parameter
    required this.items,
    this.selectedValue,
  }) : super(key: key);

  @override
  State<EBDropdownButton> createState() => _EBDropdownButtonState();
}

class _EBDropdownButtonState extends State<EBDropdownButton> {
  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: EBColor.dark),
    );

    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          'Placeholder...',
          style: TextStyle(
            fontSize: EBFontSize.normal,
            color: Theme.of(context).hintColor,
          ),
        ),
        items: widget.items.map((var item) {
          return DropdownMenuItem<String>(
            value: item,
            child: EBTypography.text(text: item),
          );
        }).toList(),
        value: widget.selectedValue,
        onChanged: (String? value) {
          setState(() => widget.selectedValue = value);
        },
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.fromLTRB(0.0, 5.0, 15.0, 5.0),
          decoration: boxDecoration,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          offset: const Offset(0, -10),
          decoration: boxDecoration,
          elevation: 0,
        ),
      ),
    );
  }
}
 */
