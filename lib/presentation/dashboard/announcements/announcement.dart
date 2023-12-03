import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/anct_controller.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/data/viewmodel/announcement_view_model.dart';
import 'package:ebayan/presentation/dashboard/comments/comment_section.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  _AnnouncementScreenState createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  final AnnouncementController _announcementController = AnnouncementController();
  late String userType; // Declare userType

  @override
  void initState() {
    super.initState();
    _fetchUserType(); // Fetch userType when the screen initializes
  }

  @override
  Widget build(BuildContext context) {
    String annId = ModalRoute.of(context)?.settings.arguments as String;
    Future<AnnouncementViewModel> _announcementFuture = _announcementController.fetchAnnouncementDetails(annId);

    return FutureBuilder<AnnouncementViewModel>(
      future: _announcementFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: EBLoadingScreen(),
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
          AnnouncementViewModel announcement = snapshot.data!;
          return Scaffold(
            appBar: EBAppBar(
              enablePop: true,
              noTitle: true,
              more: userType == "RESIDENT" ? false : true,
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
                          EBTypography.text(
                            text: announcement.body.toString(),
                            textAlign: TextAlign.justify,
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
                                  Icon(FeatherIcons.thumbsUp, size: 13, color: EBColor.primary),
                                  const SizedBox(width: 3),
                                  EBTypography.small(text: 'Like', color: EBColor.primary),
                                ],
                              ),
                              const SizedBox(width: Spacing.lg),
                              Row(
                                children: [
                                  Icon(FeatherIcons.thumbsDown, size: 13, color: EBColor.primary),
                                  const SizedBox(width: 3),
                                  EBTypography.small(text: 'Dislike', color: EBColor.primary),
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
                      const SizedBox(height: Spacing.md), // Position at the bottom center
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<void> _fetchUserType() async {
    final userController = UserController();

    // Use Firebase Authentication to get the currently authenticated user
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final currentUserType = await userController.getUserType(user.uid);
      setState(() {
        userType = currentUserType;
      });
    }
  }
}
