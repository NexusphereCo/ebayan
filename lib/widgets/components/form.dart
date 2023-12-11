import 'dart:async';

import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/size.dart';

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
  final bool? isDense;
  final int? maxLines;
  final String? placeholder;
  final bool? capitalizePerWord;
  final TextCapitalization? textCapitalization;

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
    this.capitalizePerWord,
    this.textCapitalization,
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
      onChanged: (value) {
        (capitalizePerWord ?? false)
            ? controller!.value = controller!.value.copyWith(
                text: capitalize(value),
                selection: TextSelection.fromPosition(
                  TextPosition(offset: capitalize(value).length),
                ),
              )
            : null;
      },
      textCapitalization: textCapitalization ?? TextCapitalization.none,
    );
  }

  String capitalize(String value) {
    if (value.isEmpty) {
      return value;
    }
    return value.split(' ').map((word) => word[0].toUpperCase() + word.substring(1)).join(' ');
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

class EBPinCodeTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final StreamController<ErrorAnimationType>? errorController;
  final void Function(String)? onChangeHandler;
  final int length;
  final String? Function(String?)? validator;

  const EBPinCodeTextField({
    super.key,
    required this.textEditingController,
    required this.errorController,
    required this.onChangeHandler,
    this.length = 5,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final fieldWidth = MediaQuery.of(context).size.width / 8;
    const fieldWidthMax = 50.0;
    final pinTheme = PinTheme(
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(8.0),
      inactiveColor: EBColor.primary,
      activeColor: EBColor.primary,
      selectedColor: EBColor.primary,
      errorBorderColor: EBColor.red,
      inactiveBorderWidth: 1,
      activeBorderWidth: 1,
      selectedBorderWidth: 2,
      fieldHeight: 50.0,
      fieldWidth: (fieldWidth >= fieldWidthMax) ? fieldWidthMax : fieldWidth,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: PinCodeTextField(
        appContext: context,
        pinTheme: pinTheme,
        textStyle: TextStyle(
          color: EBColor.primary,
          fontWeight: EBFontWeight.regular,
          fontSize: EBFontSize.normal,
        ),
        hintStyle: TextStyle(
          color: EBColor.primary.withOpacity(0.5),
          fontWeight: EBFontWeight.regular,
          fontSize: EBFontSize.normal,
        ),
        hintCharacter: '-',
        cursorColor: EBColor.primary,
        length: length,
        animationType: AnimationType.scale,
        validator: validator,
        animationDuration: const Duration(milliseconds: 300),
        errorAnimationController: errorController,
        controller: textEditingController,
        keyboardType: TextInputType.number,
        onChanged: onChangeHandler,
        beforeTextPaste: (text) {
          debugPrint("Allowing to paste $text");
          return true;
        },
      ),
    );
  }
}
