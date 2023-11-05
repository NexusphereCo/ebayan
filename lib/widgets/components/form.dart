import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    const borderRadius = 8.0;

    return TextFormField(
      onTap: onTap,
      enabled: enabled,
      keyboardType: TextInputType.text,
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
      errorBorderColor: EBColor.red,
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

class EBDropdownButton extends StatefulWidget {
  final List<String> items;
  String? selectedValue;

  EBDropdownButton({
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
