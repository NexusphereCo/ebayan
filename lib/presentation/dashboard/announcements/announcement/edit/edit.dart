import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/constants/validation.dart';
import 'package:ebayan/data/viewmodel/announcement_view_model.dart';
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
import 'package:logger/logger.dart';

class EditAnnouncementScreen extends StatefulWidget {
  const EditAnnouncementScreen({super.key});

  @override
  State<EditAnnouncementScreen> createState() => _EditAnnouncementScreenState();
}

class _EditAnnouncementScreenState extends State<EditAnnouncementScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Logger log = Logger();
  final AnnouncementController _announcementController = AnnouncementController();
  final TextEditingController _headingController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  CardOptions? selectedMenu;

  @override
  Widget build(BuildContext context) {
    String annId = ModalRoute.of(context)?.settings.arguments as String;
    Future<AnnouncementViewModel> announcementFuture = _announcementController.fetchAnnouncementDetails(annId);
    return FutureBuilder<AnnouncementViewModel>(
      future: announcementFuture,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case ConnectionState.none:
            return const Scaffold(
              body: Center(
                child: Text('Announcement not found.'),
              ),
            );
          default:
            AnnouncementViewModel announcement = snapshot.data!;
            _headingController.text = announcement.heading;
            _bodyController.text = announcement.body;
            return Scaffold(
              appBar: const EBAppBar(enablePop: true, noTitle: true),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(Global.paddingBody),
                  child: Form(
                    key: _formKey,
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
                              controller: _headingController,
                              placeholder: 'Subject',
                              validator: (value) {
                                value = value?.trim();
                                if (value == null || value.isEmpty) return Validation.missingField;
                                return null;
                              },
                            ),
                            const SizedBox(height: Spacing.md),
                            EBTextField(
                              label: 'Body',
                              type: TextInputType.text,
                              controller: _bodyController,
                              maxLines: 12,
                              placeholder: 'Announce something to your Barangay Sphere',
                              validator: (value) {
                                value = value?.trim();
                                if (value == null || value.isEmpty) return Validation.missingField;
                                return null;
                              },
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
                                        )),
                                    const PopupMenuItem<CardOptions>(
                                        value: CardOptions.itemTwo,
                                        height: 30,
                                        child: Row(
                                          children: [
                                            Icon(FeatherIcons.image, size: EBFontSize.h4),
                                            SizedBox(width: 5),
                                            Text(
                                              'Add Photo',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        )),
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
                                        if (_formKey.currentState?.validate() == true) {
                                          try {
                                            String data = await _announcementController.updateAnnouncement(
                                              annId,
                                              _headingController.text,
                                              _bodyController.text,
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
                                            log.e('An error occurred: $e');
                                            throw 'An error occurred while updating the announcement.';
                                          }
                                        }
                                      },
                                    ),
                                  ],
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
              ),
            );
        }
      },
    );
  }
}
