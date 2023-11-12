import 'dart:async';

import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

Widget buildPinCodeTextField({
  required BuildContext context,
  required TextEditingController textEditingController,
  required StreamController<ErrorAnimationType>? errorController,
  required void Function(String)? onChangeHandler,
}) {
  // stylings
  var fieldWidth = MediaQuery.of(context).size.width / 8;
  var fieldWidthMax = 50.0;
  var pinTheme = PinTheme(
    shape: PinCodeFieldShape.box,
    borderRadius: BorderRadius.circular(EBBorderRadius.sm),
    inactiveColor: EBColor.primary,
    activeColor: EBColor.primary,
    selectedColor: EBColor.primary,
    errorBorderColor: EBColor.red,
    inactiveBorderWidth: 1,
    activeBorderWidth: 1,
    selectedBorderWidth: 2,
    fieldHeight: 60.0,
    fieldWidth: (fieldWidth >= fieldWidthMax) ? fieldWidthMax : fieldWidth,
  );

  // widget
  return PinCodeTextField(
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
    length: 5,
    animationType: AnimationType.scale,
    validator: (v) {
      if (v!.length < 5) return Validation.minLengthBrgyCode;
      return null;
    },
    animationDuration: const Duration(milliseconds: 300),
    errorAnimationController: errorController,
    controller: textEditingController,
    keyboardType: TextInputType.number,
    onChanged: onChangeHandler,
    beforeTextPaste: (text) {
      /// if you return true then it will show the paste confirmation dialog.
      /// Otherwise if false, then nothing will happen. but you can show anything
      /// you want here, like your pop up saying wrong paste format or etc
      debugPrint("Allowing to paste $text");
      return true;
    },
  );
}
