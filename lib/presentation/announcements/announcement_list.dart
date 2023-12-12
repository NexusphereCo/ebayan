import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/anct_controller.dart';
import 'package:ebayan/controller/brgy_controller.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/data/viewmodel/barangay_view_model.dart';
import 'package:ebayan/presentation/announcements/states/content.dart';
import 'package:ebayan/presentation/announcements/states/empty.dart';
import 'package:ebayan/presentation/announcements/widgets/heading.dart';
import 'package:ebayan/utils/global.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/layout_components/appbar_top.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnnouncementListScreen extends StatefulWidget {
  const AnnouncementListScreen({super.key});

  @override
  State<AnnouncementListScreen> createState() => _AnnouncementListScreenState();
}

class _AnnouncementListScreenState extends State<AnnouncementListScreen> {
  // Controllers
  final AnnouncementController announcementController = AnnouncementController();
  final BarangayController brgyController = BarangayController();
  final UserController userController = UserController();

  // Variables
  String brgyId = '';
  String userType = '';

  @override
  void initState() {
    connectionHandler(context);
    setUserType();
    super.initState();
  }

  Future<void> setUserType() async {
    final user = await userController.getCurrentUserInfo();
    setState(() {
      brgyId = user.barangayAssociated!;
      userType = user.userType;
    });
  }

  Future<BarangayViewModel> fetchBarangayInfo() async {
    final user = await userController.getCurrentUserInfo();
    return await brgyController.fetchBarangay(user.barangayAssociated as String);
  }

  @override
  Widget build(BuildContext context) {
    final floatingActionButton = (userType == 'OFFICIAL')
        ? SizedBox(
            width: 70.0,
            height: 70.0,
            child: FittedBox(
              child: FloatingActionButton(
                backgroundColor: EBColor.primary,
                onPressed: () => Navigator.of(context).push(createRoute(route: Routes.createAnnouncement, args: brgyId)),
                child: Icon(FontAwesomeIcons.pencil, color: EBColor.light, size: EBFontSize.h3),
              ),
            ),
          )
        : null;

    return Scaffold(
      appBar: const EBAppBar(enablePop: true),
      drawer: const EBDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(Global.paddingBody),
        child: FutureBuilder(
          future: fetchBarangayInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  buildLoadingHeading(),
                  const EBCircularLoadingIndicator(showText: true),
                ],
              );
            } else {
              final BarangayViewModel barangay = snapshot.data!;

              return RefreshIndicator(
                onRefresh: () async => setState(() {}),
                backgroundColor: EBColor.light,
                child: ListView.builder(
                  itemCount: barangay.announcements!.isEmpty ? 1 : barangay.announcements!.length,
                  itemBuilder: (context, index) {
                    return barangay.announcements!.isEmpty //
                        ? EmptyAnnouncements(barangay: barangay)
                        : RenderAnnouncements(index: index, barangay: barangay);
                  },
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
