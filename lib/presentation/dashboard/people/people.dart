import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/brgy_controller.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/data/viewmodel/barangay_view_model.dart';
import 'package:ebayan/data/viewmodel/user_view_model.dart';
import 'package:ebayan/presentation/dashboard/dashboard/widgets/card_sphere.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/components/snackbar.dart';
import 'package:ebayan/widgets/layout_components/appbar_bottom.dart';
import 'package:ebayan/widgets/layout_components/appbar_top.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/heading.dart';

enum CardOptions { itemOne }

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({super.key});

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  // Controllers
  final BarangayController brgyController = BarangayController();
  final UserController userController = UserController();

  // Variables
  List<UserViewModel> users = [];
  bool isLoading = true;

  Future<List<UserViewModel>> fetchPeople() async {
    UserViewModel user = await userController.getCurrentUserInfo();
    String brgyCode = user.barangayAssociated!;
    return await brgyController.fetchBarangayUsers(brgyCode);
  }

  Future<BarangayViewModel> fetchBarangayInfo() async {
    UserViewModel user = await userController.getCurrentUserInfo();
    String brgyCode = user.barangayAssociated!;
    return await brgyController.fetchBarangay(brgyCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBAppBar(),
      drawer: const EBDrawer(),
      body: RefreshIndicator(
        color: EBColor.light,
        backgroundColor: EBColor.primary,
        onRefresh: () async => setState(() {}),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(Global.paddingBody),
              child: FutureBuilder(
                future: fetchBarangayInfo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [
                        buildLoadingHeading(),
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                          child: const SphereCard(isLoading: true).cardHeader(),
                        ),
                      ],
                    );
                  } else {
                    BarangayViewModel data = snapshot.data!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildHeading(numOfPeople: data.numOfPeople ?? 0),
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                          child: SphereCard(
                            brgyName: data.name,
                            brgyCode: data.code.toString(),
                          ).cardHeader(),
                        ),
                        const SizedBox(height: Spacing.md),
                        // Render the rows
                        FutureBuilder(
                          future: fetchPeople(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const EBCircularLoadingIndicator();
                            } else {
                              final users = snapshot.data!;

                              return SizedBox(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.5,
                                child: ListView.builder(
                                  itemCount: users.length,
                                  itemBuilder: (context, index) {
                                    return buildUserRowInfo(users[index]);
                                  },
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const EBAppBarBottom(activeIndex: 2),
    );
  }

  Row buildUserRowInfo(UserViewModel model) {
    CardOptions? selectedMenu;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(FeatherIcons.user),
            const SizedBox(width: Spacing.md),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EBTypography.text(text: '${model.firstName} ${model.lastName}'),
                EBTypography.small(text: model.contactNumber, muted: true),
              ],
            ),
          ],
        ),
        Column(
          children: [
            StatefulBuilder(
              builder: (context, setState) {
                return PopupMenuButton<CardOptions>(
                  offset: const Offset(0, 40),
                  icon: Icon(
                    FeatherIcons.moreHorizontal,
                    color: EBColor.dark,
                  ),
                  initialValue: selectedMenu,
                  onSelected: (CardOptions item) {
                    setState(() => selectedMenu = item);
                    if (item == CardOptions.itemOne) {
                      Clipboard.setData(ClipboardData(text: model.contactNumber));
                      ScaffoldMessenger.of(context).showSnackBar(
                        EBSnackBar.info(text: '${model.firstName} ${model.lastName}\'s phone number has been copied to clipboard.'),
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<CardOptions>>[
                    PopupMenuItem<CardOptions>(
                      value: CardOptions.itemOne,
                      height: 40,
                      child: Text('Copy ${model.lastName}\'s phone no.'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
