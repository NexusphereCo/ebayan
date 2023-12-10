import 'dart:convert';

import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/anct_controller.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/data/viewmodel/announcement_view_model.dart';
import 'package:ebayan/data/viewmodel/user_view_model.dart';
import 'package:ebayan/presentation/dashboard/comments/comment_section.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/layout_components/appbar_top.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  final UserController userController = UserController();
  final AnnouncementController announcementController = AnnouncementController();
  QuillController bodyController = QuillController.basic();
  late String userType;

  @override
  void initState() {
    super.initState();
    setUserType();
  }

  Future<void> setUserType() async {
    UserViewModel user = await userController.getCurrentUserInfo();
    userType = await userController.getUserType(user.id);
  }

  Future<AnnouncementViewModel> fetchAnnouncementDetails(String annId) async {
    return await announcementController.fetchAnnouncementDetails(annId);
  }

  @override
  Widget build(BuildContext context) {
    String annId = ModalRoute.of(context)?.settings.arguments as String;

    return FutureBuilder(
      future: fetchAnnouncementDetails(annId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const EBCustomLoadingScreen(solid: true);
        } else {
          AnnouncementViewModel announcement = snapshot.data!;
          bodyController.document = Document.fromJson(jsonDecode(announcement.body));

          return RenderAnnouncement(
            userType: userType,
            announcement: announcement,
            bodyController: bodyController,
            annId: annId,
          );
        }
      },
    );
  }
}

class RenderAnnouncement extends StatelessWidget {
  final String userType;
  final AnnouncementViewModel announcement;
  final QuillController bodyController;
  final String annId;

  const RenderAnnouncement({
    super.key,
    required this.userType,
    required this.announcement,
    required this.bodyController,
    required this.annId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EBAppBar(
        enablePop: true,
        save: userType == "OFFICIAL" ? false : true,
        more: userType == "RESIDENT" ? false : true,
        noTitle: true,
        annId: announcement.id,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(Global.paddingBody),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    EBTypography.h2(
                      text: announcement.heading,
                      color: EBColor.primary,
                    ),
                    const SizedBox(height: Spacing.sm),
                    Row(
                      children: [
                        const Icon(FeatherIcons.feather, size: 13, color: Colors.black45),
                        EBTypography.small(text: announcement.author, muted: true), // authorName
                      ],
                    ),
                    EBTypography.small(text: announcement.formattedTime, muted: true), // timeCreated
                  ],
                ),
                const SizedBox(height: Spacing.md),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QuillProvider(
                      configurations: QuillConfigurations(
                        controller: bodyController,
                      ),
                      child: Column(
                        children: [
                          QuillEditor.basic(
                            configurations: const QuillEditorConfigurations(
                              minHeight: 50,
                              readOnly: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: Spacing.xl),
                    EBTypography.small(text: 'What do you think about this post?', fontWeight: FontWeight.bold),
                    const SizedBox(height: Spacing.sm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              FeatherIcons.thumbsUp,
                              size: EBFontSize.h3,
                              color: EBColor.primary,
                            ),
                            const SizedBox(width: 3),
                            EBTypography.text(text: 'Like', color: EBColor.primary),
                          ],
                        ),
                        const SizedBox(width: Spacing.lg),
                        Row(
                          children: [
                            Icon(
                              FeatherIcons.thumbsDown,
                              size: EBFontSize.h3,
                              color: EBColor.primary,
                            ),
                            const SizedBox(width: 3),
                            EBTypography.text(text: 'Dislike', color: EBColor.primary),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: Spacing.xl),
                EBButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => CommentSection(annId: annId),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                      ),
                    );
                  },
                  text: 'View Comment',
                  theme: EBButtonTheme.primaryOutlined,
                  icon: const Icon(
                    FeatherIcons.messageCircle,
                    size: EBFontSize.h2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
