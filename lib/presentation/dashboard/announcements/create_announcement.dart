import 'dart:convert';

import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/widgets/components/form.dart';
import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/controller/anct_controller.dart';
import 'package:ebayan/presentation/dashboard/announcements/widgets/switch_button.dart';
import 'package:flutter_quill/flutter_quill.dart';

class CreateAnnouncementScreen extends StatefulWidget {
  const CreateAnnouncementScreen({super.key});

  @override
  _CreateAnnouncementScreenState createState() => _CreateAnnouncementScreenState();
}

class _CreateAnnouncementScreenState extends State<CreateAnnouncementScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AnnouncementController announcementController = AnnouncementController();
  final TextEditingController headingController = TextEditingController();
  QuillController bodyController = QuillController.basic();
  CardOptions? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBAppBar(enablePop: true, noTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Global.paddingBody),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EBTypography.h1(
                      text: 'Create Announcement',
                      color: EBColor.primary,
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.sm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EBTypography.h4(
                      text: "Send SMS",
                      muted: true,
                    ),
                    const SwitchButton(),
                    EBTypography.small(
                      maxLines: 2,
                      text: 'This will send a group text a message to all people within the barangay.',
                      muted: true,
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.md),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EBTextField(
                      label: 'Heading',
                      type: TextInputType.text,
                      controller: headingController,
                      placeholder: 'Subject',
                      validator: (value) {
                        value = value?.trim();
                        if (value == null || value.isEmpty) return Validation.missingField;
                        return null;
                      },
                    ),
                    const SizedBox(height: Spacing.md),
                    QuillProvider(
                      configurations: QuillConfigurations(
                        controller: bodyController,
                        sharedConfigurations: const QuillSharedConfigurations(
                          locale: Locale('de'),
                        ),
                      ),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: EBColor.dark, // Set your desired border color
                              width: 1.0, // Set your desired border width
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              QuillEditor.basic(
                                configurations: QuillEditorConfigurations(
                                  customStyles: DefaultStyles(
                                      placeHolder: DefaultTextBlockStyle(
                                          const TextStyle(
                                            fontSize: 13,
                                            fontWeight: EBFontWeight.regular,
                                            color: Color.fromRGBO(2, 4, 21, 0.5),
                                          ),
                                          const VerticalSpacing(0.0, 0.0),
                                          const VerticalSpacing(1.0, 1.0),
                                          BoxDecoration(border: Border.all(width: 3.0)))),
                                  minHeight: 250,
                                  readOnly: false,
                                  maxHeight: 500,
                                  padding: const EdgeInsets.all(Global.paddingBody),
                                  placeholder: 'Announce something to your barangay sphere',
                                  textCapitalization: TextCapitalization.sentences,
                                ),
                              ),
                              const QuillToolbar(
                                configurations: QuillToolbarConfigurations(
                                  showBoldButton: true,
                                  showItalicButton: true,
                                  showUnderLineButton: true,
                                  showListBullets: true,
                                  showUndo: true,
                                  showRedo: true,
                                  toolbarIconCrossAlignment: WrapCrossAlignment.start,
                                  // ----------
                                  showDividers: false,
                                  showFontFamily: false,
                                  showFontSize: false,
                                  showSmallButton: false,
                                  showStrikeThrough: false,
                                  showInlineCode: false,
                                  showColorButton: false,
                                  showBackgroundColorButton: false,
                                  showClearFormat: false,
                                  showAlignmentButtons: false,
                                  showLeftAlignment: false,
                                  showCenterAlignment: false,
                                  showRightAlignment: false,
                                  showJustifyAlignment: false,
                                  showHeaderStyle: false,
                                  showListNumbers: false,
                                  showListCheck: false,
                                  showCodeBlock: false,
                                  showQuote: false,
                                  showIndent: false,
                                  showLink: false,
                                  showDirection: false,
                                  showSearchButton: false,
                                  showSubscript: false,
                                  showSuperscript: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.md),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PopupMenuButton<CardOptions>(
                          offset: const Offset(0, -90),
                          icon: Icon(
                            FeatherIcons.plusCircle,
                            color: EBColor.primary,
                          ),
                          initialValue: selectedMenu,
                          onSelected: (CardOptions item) {
                            setState(() {
                              selectedMenu = item;
                            });
                          },
                          itemBuilder: (BuildContext context) => <PopupMenuEntry<CardOptions>>[
                            const PopupMenuItem<CardOptions>(
                              value: CardOptions.itemOne,
                              height: 30,
                              child: Row(
                                children: [
                                  Icon(FeatherIcons.paperclip, size: EBFontSize.h4),
                                  SizedBox(width: 5),
                                  Text(
                                    'Add Attachment(s)',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            EBButton(
                              text: 'Cancel',
                              theme: EBButtonTheme.primaryOutlined,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            const SizedBox(width: Spacing.sm),
                            EBButton(
                                text: 'Post',
                                theme: EBButtonTheme.primary,
                                icon: Icon(FeatherIcons.send, color: EBColor.light, size: EBFontSize.h4),
                                onPressed: () async {
                                  if (formKey.currentState?.validate() == true) {
                                    try {
                                      final json = jsonEncode(bodyController.document.toDelta().toJson());
                                      String data = await announcementController.createAnnouncement(
                                        headingController.text,
                                        json.toString(),
                                      );
                                      if (context.mounted) {
                                        Navigator.of(context).pushReplacement(
                                          createRoute(
                                            route: Routes.announcement,
                                            args: data,
                                          ),
                                        );
                                      }
                                    } catch (e) {
                                      throw 'An error occurred while creating the announcement.';
                                    }
                                  }
                                }),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
