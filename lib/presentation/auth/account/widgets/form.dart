import 'package:bottom_picker/bottom_picker.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/data/viewmodel/user_view_model.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/utils/fade_in.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'large_button.dart';

Widget buildForm({
  required GlobalKey<FormState> formKey,
  required UserViewModel userData,
  // controllers
  required TextEditingController firstNameController,
  required TextEditingController lastNameController,
  required TextEditingController emailController,
  required TextEditingController contactNumberController,
  required TextEditingController addressController,
  required TextEditingController birthDateController,
  required dynamic Function(dynamic) birthDateOnTapHandler,
  // variables
  required bool isEditing,
  required void Function() onEditHandler,
  required void Function() onLogoutHandler,
  required BuildContext context,
}) {
  final inputDecoration = InputDecoration(
    contentPadding: EdgeInsets.zero,
    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: EBColor.dark[50]!)),
    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: EBColor.primary)),
    isDense: true,
  );
  return FadeIn(
    child: Padding(
      padding: const EdgeInsets.all(Global.paddingBody),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: EBColor.light,
                border: Border.all(color: EBColor.green),
                borderRadius: BorderRadius.circular(EBBorderRadius.lg),
              ),
              child: Padding(
                padding: const EdgeInsets.all(Spacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(FeatherIcons.user, size: EBFontSize.h2),
                            const SizedBox(width: Spacing.sm),
                            EBTypography.h4(text: 'Personal Information'),
                          ],
                        ),
                        TextButton(
                          onPressed: onEditHandler,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              EBTypography.label(
                                text: (isEditing) ? 'Discard' : 'Edit',
                                color: (isEditing) ? EBColor.red : EBColor.green,
                              ),
                              const SizedBox(width: Spacing.sm),
                              Icon(
                                FeatherIcons.edit,
                                color: (isEditing) ? EBColor.red : EBColor.green,
                                size: EBFontSize.h4,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        EBTypography.text(text: 'First Name:', muted: true),
                        const SizedBox(width: Spacing.sm),
                        (isEditing)
                            ? Expanded(
                                child: TextFormField(
                                  controller: firstNameController,
                                  keyboardType: TextInputType.name,
                                  style: const TextStyle(fontSize: EBFontSize.normal),
                                  decoration: inputDecoration,
                                ),
                              )
                            : EBTypography.text(text: userData.firstName, muted: true),
                      ],
                    ),
                    const SizedBox(height: Spacing.sm),
                    Row(
                      children: [
                        EBTypography.text(text: 'Last Name:', muted: true),
                        const SizedBox(width: Spacing.sm),
                        (isEditing)
                            ? Expanded(
                                child: TextFormField(
                                  controller: lastNameController,
                                  keyboardType: TextInputType.name,
                                  style: const TextStyle(fontSize: EBFontSize.normal),
                                  decoration: inputDecoration,
                                ),
                              )
                            : EBTypography.text(text: userData.lastName, muted: true),
                      ],
                    ),
                    const SizedBox(height: Spacing.sm),
                    Row(
                      children: [
                        EBTypography.text(text: 'Birth Date:', muted: true),
                        const SizedBox(width: Spacing.sm),
                        (isEditing)
                            ? Expanded(
                                child: TextFormField(
                                  controller: birthDateController,
                                  style: const TextStyle(fontSize: EBFontSize.normal),
                                  decoration: inputDecoration,
                                  readOnly: true,
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
                                ),
                              )
                            : EBTypography.text(text: DateFormat('MMM dd, yyyy').format(DateTime.parse(userData.birthDate)), muted: true),
                      ],
                    ),
                    const SizedBox(height: Spacing.lg),
                    Row(
                      children: [
                        const Icon(FeatherIcons.phone, size: EBFontSize.h2),
                        const SizedBox(width: Spacing.sm),
                        EBTypography.h4(text: 'Contact Information'),
                      ],
                    ),
                    const SizedBox(height: Spacing.md),
                    Row(
                      children: [
                        EBTypography.text(text: 'Phone No.:', muted: true),
                        const SizedBox(width: Spacing.sm),
                        (isEditing)
                            ? Expanded(
                                child: TextFormField(
                                  controller: contactNumberController,
                                  keyboardType: TextInputType.phone,
                                  style: const TextStyle(fontSize: EBFontSize.normal),
                                  decoration: inputDecoration,
                                ),
                              )
                            : EBTypography.text(text: userData.contactNumber, muted: true),
                      ],
                    ),
                    const SizedBox(height: Spacing.sm),
                    Row(
                      children: [
                        EBTypography.text(text: 'Email Address:', muted: true),
                        const SizedBox(width: Spacing.sm),
                        (isEditing)
                            ? Expanded(
                                child: TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(fontSize: EBFontSize.normal),
                                  decoration: inputDecoration,
                                ),
                              )
                            : EBTypography.text(text: userData.email, muted: true),
                      ],
                    ),
                    const SizedBox(height: Spacing.lg),
                    Row(
                      children: [
                        const Icon(FeatherIcons.mapPin, size: EBFontSize.h2),
                        const SizedBox(width: Spacing.sm),
                        EBTypography.h4(text: 'Address'),
                      ],
                    ),
                    const SizedBox(height: Spacing.md),
                    (isEditing)
                        ? TextFormField(
                            controller: addressController,
                            style: const TextStyle(fontSize: EBFontSize.normal),
                            decoration: inputDecoration,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                          )
                        : EBTypography.text(
                            text: userData.address,
                            muted: true,
                            textAlign: TextAlign.start,
                          ),
                    const SizedBox(height: Spacing.md),
                    (isEditing)
                        ? FadeIn(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                EBButton(
                                  onPressed: () {},
                                  text: 'Save',
                                  theme: EBButtonTheme.successOutlined,
                                  icon: const Icon(FeatherIcons.arrowRight, size: EBFontSize.normal),
                                  size: EBButtonSize.sm,
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Spacing.lg),
            LargeCustomButton(
              heading: 'Change Password',
              lead: 'Manage your login credentials',
              icon: Icon(FeatherIcons.lock, color: EBColor.light),
              onTap: () {},
            ),
            const SizedBox(height: Spacing.sm),
            LargeCustomButton(
              heading: 'Logout',
              lead: 'Sign-out and come back for news later!',
              icon: Icon(FeatherIcons.logOut, color: EBColor.light),
              onTap: onLogoutHandler,
            ),
          ],
        ),
      ),
    ),
  );
}
