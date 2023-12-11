import 'dart:convert';

import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/icons.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/controller/anct_controller.dart';
import 'package:ebayan/data/viewmodel/announcement_view_model.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/form.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/components/snackbar.dart';
import 'package:ebayan/widgets/layout_components/appbar_top.dart';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter/material.dart';

class EditAnnouncementScreen extends StatefulWidget {
  const EditAnnouncementScreen({super.key});

  @override
  State<EditAnnouncementScreen> createState() => _EditAnnouncementScreenState();
}

class _EditAnnouncementScreenState extends State<EditAnnouncementScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AnnouncementController announcementController = AnnouncementController();
  final EBCustomLoadingScreen loadingScreen = const EBCustomLoadingScreen();
  // Controllers
  final TextEditingController headingController = TextEditingController();
  QuillController bodyController = QuillController.basic();

  Future<AnnouncementViewModel> fetchAnnouncement(String annId) async {
    return await announcementController.fetchAnnouncementDetails(annId);
  }

  Future<void> editAnnouncement(String annId) async {
    bool isFormValid = formKey.currentState?.validate() == true;
    if (isFormValid) {
      try {
        loadingScreen.show(context);
        // Check if the body is empty
        bool isBodyEmpty = bodyController.document.toPlainText().trim().isEmpty;
        if (isBodyEmpty) throw Validation.missingBodyField;

        // If everything is valid, then update
        final json = jsonEncode(bodyController.document.toDelta().toJson());

        String data = await announcementController.updateAnnouncement(annId, headingController.text, json.toString());

        // Go back to announcement
        if (context.mounted) {
          loadingScreen.hide(context);
          Navigator.of(context).pushReplacement(
            createRoute(route: Routes.announcement, args: data),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            EBSnackBar.info(text: e.toString().isEmpty ? 'An error occurred while updating the announcement.' : e.toString()),
          );
          loadingScreen.hide(context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String annId = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: const EBAppBar(enablePop: true, noTitle: true),
      body: FutureBuilder(
        future: fetchAnnouncement(annId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return EBCircularLoadingIndicator(
              height: MediaQuery.of(context).size.height * 0.75,
              showText: true,
            );
          } else {
            AnnouncementViewModel announcement = snapshot.data!;
            headingController.text = announcement.heading;
            bodyController.document = Document.fromJson(jsonDecode(announcement.body));

            return SingleChildScrollView(
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
                            text: 'Edit Announcement',
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
                          EBTypography.label(text: 'Body', muted: true),
                          const SizedBox(height: Spacing.sm),
                          RenderRichTextArea(bodyController: bodyController),
                        ],
                      ),
                      const SizedBox(height: Spacing.md),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const RenderAttachButton(),
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
                                onPressed: () => editAnnouncement(annId),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: Spacing.md),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class RenderAttachButton extends StatefulWidget {
  const RenderAttachButton({super.key});

  @override
  State<RenderAttachButton> createState() => _RenderAttachButtonState();
}

class _RenderAttachButtonState extends State<RenderAttachButton> {
  CardOptions? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<CardOptions>(
      offset: const Offset(0, -75),
      icon: Icon(
        FeatherIcons.plusCircle,
        color: EBColor.primary,
      ),
      initialValue: selectedMenu,
      onSelected: (CardOptions item) {},
      itemBuilder: (BuildContext context) => <PopupMenuEntry<CardOptions>>[
        const PopupMenuItem<CardOptions>(
          value: CardOptions.itemOne,
          height: 30,
          child: Row(
            children: [
              Icon(EBIcons.clip, size: EBFontSize.h1),
              SizedBox(width: 5),
              Text('Add Attachment(s)', style: TextStyle(fontSize: EBFontSize.label)),
            ],
          ),
        ),
        const PopupMenuItem<CardOptions>(
          value: CardOptions.itemTwo,
          height: 30,
          child: Row(
            children: [
              Icon(EBIcons.image, size: EBFontSize.h1),
              SizedBox(width: 5),
              Text('Add Photo', style: TextStyle(fontSize: EBFontSize.label)),
            ],
          ),
        ),
      ],
    );
  }
}

class RenderRichTextArea extends StatelessWidget {
  const RenderRichTextArea({
    super.key,
    required this.bodyController,
  });

  final QuillController bodyController;

  // Editor configuration...
  QuillEditorConfigurations editorConfigurations() {
    return QuillEditorConfigurations(
      customStyles: DefaultStyles(
        placeHolder: DefaultTextBlockStyle(
          TextStyle(
            fontFamily: EBTypography.fontFamily,
            fontWeight: EBFontWeight.regular,
            fontSize: EBFontSize.label,
            color: EBColor.dark.withOpacity(0.5),
          ),
          const VerticalSpacing(0.0, 0.0),
          const VerticalSpacing(1.0, 1.0),
          BoxDecoration(
            border: Border.all(width: 3.0),
          ),
        ),
      ),
      minHeight: 250,
      readOnly: false,
      maxHeight: 500,
      padding: const EdgeInsets.all(Global.paddingBody),
      placeholder: 'Announce something to your barangay sphere',
      textCapitalization: TextCapitalization.sentences,
    );
  }

  // Allowed formatting buttons to show are modified here...
  QuillToolbarConfigurations toolbarConfiguration() {
    return const QuillToolbarConfigurations(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return QuillProvider(
      configurations: QuillConfigurations(
        controller: bodyController,
        sharedConfigurations: const QuillSharedConfigurations(
          locale: Locale('de'),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: EBColor.dark, width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QuillEditor.basic(configurations: editorConfigurations()),
            QuillToolbar(configurations: toolbarConfiguration()),
          ],
        ),
      ),
    );
  }
}
