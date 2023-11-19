import 'package:ebayan/constants/typography.dart';
import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/controller/anct_controller.dart';
import 'package:ebayan/presentation/dashboard/announcements/widgets/switch_button.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class CreateAnnouncementScreen extends StatefulWidget {
  const CreateAnnouncementScreen({Key? key}) : super(key: key);

  @override
  _CreateAnnouncementScreenState createState() => _CreateAnnouncementScreenState();
}

class _CreateAnnouncementScreenState extends State<CreateAnnouncementScreen> {
  final Logger log = Logger();
  final AnnouncementController _announcementController = AnnouncementController();
  final TextEditingController _headingController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBAppBar(enablePop: true, noTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Global.paddingBody),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  EBTypography.h2(
                    text: 'Create Announcement',
                    color: EBColor.primary,
                  ),
                ],
              ),
              const SizedBox(height: Spacing.md),
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
              const SizedBox(height: Spacing.md),
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
                    ),
                  ),
                  const SizedBox(height: Spacing.md),
                  TextField(
                    controller: _bodyController,
                    textAlign: TextAlign.start,
                    maxLines: 15,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      hintText: "Announce something to your Sphere",
                      contentPadding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
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
                      IconButton(
                        padding: const EdgeInsets.only(right: 5.0),
                        icon: const Icon(FeatherIcons.calendar),
                        color: EBColor.primary,
                        onPressed: () => _selectDate(context),
                      ),
                      EBButton(
                        text: 'Cancel',
                        theme: EBButtonTheme.primaryOutlined,
                        onPressed: () {},
                      ),
                      EBButton(
                        text: 'Post',
                        theme: EBButtonTheme.primary,
                        icon: const Icon(FeatherIcons.send),
                        onPressed: () async {
                          try {
                            String heading = _headingController.text;
                            String body = _bodyController.text;

                            // Format the selected date as a string with only date and time
                            String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(_selectedDate);

                            await _announcementController.createAnnouncement({
                              'heading': heading,
                              'body': body,
                              'timeCreated': formattedDate,
                            });

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
              )
            ],
          ),
        ),
      ),
    );
  }
}
