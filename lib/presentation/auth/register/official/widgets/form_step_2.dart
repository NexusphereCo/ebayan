import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/icons.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/form.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget buildBarangayAssociation({
  required TabController tabController,
  // controllers
  required TextEditingController municipalityController,
  required TextEditingController barangayController,
  required TextEditingController proofDocController,
  // functions
  required void Function() municipalityOnTapHandler,
  required void Function() barangayOnTapHandler,
  required void Function() onClearFieldsHandler,
  required void Function() nextTabHandler,
  required void Function(dynamic) setFilePath,
  // build context
  required BuildContext context,
  // variables
  required bool isBrgyFieldEnabled,
}) =>
    ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Global.paddingBody),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EBTypography.label(text: 'Barangay Association'),
              const SizedBox(height: Spacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  EBTextBox(
                    icon: FeatherIcons.map,
                    textField: EBTextField(
                      controller: municipalityController,
                      readOnly: true,
                      label: 'Select Municipality',
                      type: TextInputType.datetime,
                      suffixIcon: Container(
                        margin: const EdgeInsets.symmetric(vertical: Spacing.md),
                        child: const FaIcon(FontAwesomeIcons.angleDown),
                      ),
                      onTap: municipalityOnTapHandler,
                      validator: (value) {
                        value = value?.trim();
                        if (value == null || value.isEmpty) return Validation.missingField;
                        return null;
                      },
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(height: Spacing.md),
                  EBTextBox(
                    icon: EBIcons.home,
                    textField: EBTextField(
                      controller: barangayController,
                      enabled: isBrgyFieldEnabled,
                      readOnly: true,
                      label: 'Barangay Associated',
                      type: TextInputType.datetime,
                      suffixIcon: Container(
                        margin: const EdgeInsets.symmetric(vertical: Spacing.md),
                        child: const FaIcon(FontAwesomeIcons.angleDown),
                      ),
                      onTap: barangayOnTapHandler,
                      validator: (value) {
                        value = value?.trim();
                        if (value == null || value.isEmpty) return Validation.missingField;
                        return null;
                      },
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(height: Spacing.md),
                  EBTextBox(
                    icon: FeatherIcons.file,
                    textField: EBTextField(
                      controller: proofDocController,
                      readOnly: true,
                      label: 'Proof of Official',
                      type: TextInputType.text,
                      validator: (value) {
                        value = value?.trim();
                        if (value == null || value.isEmpty) return Validation.missingField;
                        return null;
                      },
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf'],
                        );

                        // the user has selected a file
                        if (result != null) {
                          String fileName = result.files.first.name;

                          proofDocController.text = fileName;
                          setFilePath(result);
                        }
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
                          EBTypography.small(text: 'PDF', muted: true),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: Spacing.md),
                  EBTypography.text(
                    text: 'Approval may take a few days as we review your submission. We\'ll notify you once it\'s approved through your contact number.',
                    muted: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: onClearFieldsHandler,
                        child: EBTypography.text(
                          text: 'Clear Information',
                          color: EBColor.red,
                          fontWeight: EBFontWeight.bold,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      EBButton(
                        text: 'Previous',
                        theme: EBButtonTheme.primaryOutlined,
                        onPressed: () => tabController.animateTo(tabController.index - 1),
                      ),
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
