import 'package:bottom_picker/bottom_picker.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/form.dart';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildPersonalInfo({
  // controllers
  required TextEditingController firstNameController,
  required TextEditingController lastNameController,
  required TextEditingController emailController,
  required TextEditingController contactNumberController,
  required TextEditingController addressController,
  required TextEditingController birthDateController,
  // functions
  required dynamic Function(dynamic) birthDateOnTapHandler,
  required void Function() nextTabHandler,
  // build context
  required BuildContext context,
}) {
  return ListView(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: Global.paddingBody),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EBTypography.label(text: 'Personal Information'),
            const SizedBox(height: Spacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 61,
                          child: Icon(
                            FeatherIcons.user,
                            color: EBColor.primary,
                          ),
                        ),
                        const SizedBox(width: Spacing.md),
                        Flexible(
                          child: EBTextField(
                            controller: firstNameController,
                            label: 'First Name',
                            type: TextInputType.name,
                            validator: (value) {
                              value = value?.trim();
                              if (value == null || value.isEmpty) return Validation.missingField;
                              return null;
                            },
                            maxLines: 1,
                            capitalizePerWord: true,
                          ),
                        ),
                        const SizedBox(width: Spacing.sm),
                        Flexible(
                          child: EBTextField(
                            controller: lastNameController,
                            label: 'Last Name',
                            type: TextInputType.name,
                            validator: (value) {
                              value = value?.trim();
                              if (value == null || value.isEmpty) return Validation.missingField;
                              return null;
                            },
                            maxLines: 1,
                            capitalizePerWord: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.md),
                EBTextBox(
                  icon: FeatherIcons.mail,
                  textField: EBTextField(
                    controller: emailController,
                    label: 'Email',
                    type: TextInputType.emailAddress,
                    validator: (value) {
                      value = value?.trim();
                      final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

                      if (value == null || value.isEmpty) {
                        return Validation.missingField;
                      } else if (!emailRegExp.hasMatch(value)) {
                        return Validation.invalidEmail;
                      }
                      return null;
                    },
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: Spacing.md),
                EBTextBox(
                  icon: FeatherIcons.phone,
                  textField: EBTextField(
                    controller: contactNumberController,
                    label: 'Contact Number',
                    type: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 11,
                    validator: (value) {
                      value = value?.trim();
                      final phoneRegExp = RegExp(r'^\d{11}$');
                      if (value == null || value.isEmpty) {
                        return Validation.missingField;
                      } else if (!phoneRegExp.hasMatch(value)) {
                        return Validation.invalidPhoneNumber;
                      }
                      return null;
                    },
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: Spacing.md),
                EBTextBox(
                  icon: FeatherIcons.mapPin,
                  textField: EBTextField(
                    controller: addressController,
                    label: 'Address',
                    type: TextInputType.multiline,
                    validator: (value) {
                      value = value?.trim();
                      if (value == null || value.isEmpty) return Validation.missingField;
                      return null;
                    },
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                const SizedBox(height: Spacing.md),
                EBTextBox(
                  icon: FeatherIcons.calendar,
                  textField: EBTextField(
                    controller: birthDateController,
                    readOnly: true,
                    label: 'Birth Date',
                    type: TextInputType.datetime,
                    onTap: () {
                      BottomPicker.date(
                        onSubmit: birthDateOnTapHandler,
                        title: '',
                        maxDateTime: DateTime.now(),
                        iconColor: EBColor.light,
                        closeIconColor: EBColor.primary,
                        buttonSingleColor: EBColor.primary,
                      ).show(context);
                    },
                    validator: (value) {
                      value = value?.trim();
                      if (value == null || value.isEmpty) return Validation.missingField;
                      return null;
                    },
                    maxLines: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: Spacing.sm),
                        EBTypography.small(text: 'YYYY-MM-DD', muted: true),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        firstNameController.text = '';
                        lastNameController.text = '';
                        emailController.text = '';
                        contactNumberController.text = '';
                        addressController.text = '';
                        birthDateController.text = '';
                      },
                      child: EBTypography.text(
                        text: 'Clear Information',
                        color: EBColor.green,
                        fontWeight: EBFontWeight.bold,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(width: Spacing.sm),
                    EBButton(
                      text: 'Next',
                      theme: EBButtonTheme.primary,
                      onPressed: nextTabHandler,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
