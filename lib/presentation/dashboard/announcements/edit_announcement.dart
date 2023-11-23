import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/data/model/announcement_model.dart';
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
  final String annId;
  const EditAnnouncementScreen({Key? key, required this.annId}) : super(key: key);

  @override
  _EditAnnouncementScreenState createState() => _EditAnnouncementScreenState();
}

class _EditAnnouncementScreenState extends State<EditAnnouncementScreen> {
  final Logger log = Logger();
  final AnnouncementController _announcementController = AnnouncementController();
  final TextEditingController _headingController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  late Future<AnnouncementModel> _announcementFuture;

  CardOptions? selectedMenu;

  @override
  void initState() {
    super.initState();
    _announcementFuture = _announcementController.viewAnnouncement(widget.annId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AnnouncementModel>(
      future: _announcementFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: Text('Announcement not found.'),
            ),
          );
        } else {
          AnnouncementModel announcement = snapshot.data!;
          _headingController.text = announcement.heading;
          _bodyController.text = announcement.body;
          return Scaffold(
            appBar: const EBAppBar(enablePop: true, noTitle: true),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Global.paddingBody),
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
                    const SizedBox(height: Spacing.md),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EBTypography.h4(
                              text: "Send SMS",
                              muted: true,
                            ),
                            const SwitchButton(),
                            EBTypography.small(
                              text: 'This will send a group text a message to all people within the barangay.',
                              muted: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: Spacing.lg),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _headingController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                            hintText: "Subject",
                            contentPadding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 15.0),
                          ),
                        ),
                        const SizedBox(height: Spacing.md),
                        TextField(
                          controller: _bodyController,
                          textAlign: TextAlign.start,
                          maxLines: 13,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                            hintText: "Announce something to your Sphere",
                            contentPadding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 15.0),
                          ),
                        )
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
                                    try {
                                      String heading = _headingController.text;
                                      String body = _bodyController.text;

                                      /*await _announcementController.updateAnnouncement(annId, heading, body)*/
                                      // Navigate to a success screen or perform other actions upon successful creation
                                    } catch (e) {
                                      log.e('An error occurred: $e');
                                      throw 'An error occurred while creating the announcement.';
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
          );
        }
      },
    );
  }
}