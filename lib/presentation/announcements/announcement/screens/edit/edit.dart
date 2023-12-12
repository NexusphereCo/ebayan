import 'dart:convert';

import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/controller/anct_controller.dart';
import 'package:ebayan/controller/brgy_controller.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/data/viewmodel/announcement_view_model.dart';
import 'package:ebayan/presentation/announcements/announcement/screens/widgets/attach_button.dart';
import 'package:ebayan/presentation/announcements/announcement/screens/widgets/quill.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/form.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/components/snackbar.dart';
import 'package:ebayan/widgets/layout_components/appbar_top.dart';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EditAnnouncementScreen extends StatefulWidget {
  const EditAnnouncementScreen({super.key});

  @override
  State<EditAnnouncementScreen> createState() => _EditAnnouncementScreenState();
}

class _EditAnnouncementScreenState extends State<EditAnnouncementScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final UserController userController = UserController();
  final BarangayController brgyController = BarangayController();
  final AnnouncementController announcementController = AnnouncementController();
  final EBCustomLoadingScreen loadingScreen = const EBCustomLoadingScreen();
  // Controllers
  final TextEditingController headingController = TextEditingController();
  QuillController bodyController = QuillController.basic();

  // Variables
  bool switchEnabled = false;

  Future<AnnouncementViewModel> fetchAnnouncement(String annId) async {
    return await announcementController.fetchAnnouncementDetails(annId);
  }

  Future<Uri> createUri(String annId) async {
    String? brgyId = await brgyController.fetchBrgyIdFromAnnId(annId);
    List<String> phoneNumber = await userController.fetchPhoneNumbersFromBrgy(brgyId!);

    String formattedBodyMsg = 'HEADING: ${headingController.text}\n-------------------\n${bodyController.document.toPlainText().trim()}';
    return Uri(
      scheme: 'sms',
      path: phoneNumber.join(','),
      queryParameters: {
        'body': formattedBodyMsg,
      },
    );
  }

  Future<void> sendSms(String annId) async {
    if (switchEnabled) {
      bool isBodyEmpty = bodyController.document.toPlainText().trim().isEmpty;
      try {
        if (!isBodyEmpty) {
          if (!await launchUrl(await createUri(annId))) throw 'Could not launch';
        } else {
          throw Validation.missingBodyField;
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            EBSnackBar.info(text: 'Please make sure that the body has a content before sending a text message.'),
          );
        }
      }
    }
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
        final jsonBody = jsonEncode(bodyController.document.toDelta().toJson());

        String announcementId = await announcementController.updateAnnouncement(annId, headingController.text, jsonBody.toString());

        // Go back to announcement
        if (context.mounted) {
          loadingScreen.hide(context);
          Navigator.of(context).pushReplacement(
            createRoute(route: Routes.announcement, args: announcementId),
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
                            color: EBColor.green,
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
                          StatefulBuilder(
                            builder: (context, setState) {
                              return SwitchButton(
                                  value: switchEnabled,
                                  onChange: (bool value) async {
                                    setState(() {
                                      switchEnabled = value;
                                    });
                                    await sendSms(annId);
                                  });
                            },
                          ),
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
