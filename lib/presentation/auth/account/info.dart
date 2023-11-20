import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/data/viewmodel/user_view_model.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/components/buttons.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/shared/appbar_bottom.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:ebayan/widgets/utils/fade_in.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widgets/confirm_logout_modal.dart';
import 'widgets/form.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final UserController _userController = UserController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final EBLoadingScreen _loadingScreen = const EBLoadingScreen();

  // TextEditingController

  // variables
  bool _isEditing = false;

  Future<UserViewModel> _fetchUserData() async {
    return await _userController.getCurrentUserInfo();
  }

  Future<void> _logOut() async {
    _loadingScreen.show(context);

    await _userController.logOut();

    if (context.mounted) {
      _loadingScreen.hide(context);
      Navigator.of(context).push(createRoute(route: '/login'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBAppBar(),
      drawer: const EBDrawer(),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 0,
            child: SvgPicture.asset(
              Asset.illustAccInfoBackg,
              fit: BoxFit.fill,
            ),
          ),
          RefreshIndicator(
            color: EBColor.light,
            backgroundColor: EBColor.dullGreen,
            onRefresh: () async => setState(() {}),
            child: ListView(
              children: [
                const SizedBox(height: Spacing.md),
                EBTypography.h1(text: 'Account Information', textAlign: TextAlign.center),
                const SizedBox(height: Spacing.xl),
                FutureBuilder(
                  future: _fetchUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: EBColor.green,
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                      );
                    } else {
                      final UserViewModel user = snapshot.data!;

                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return FadeIn(
                            child: Padding(
                              padding: const EdgeInsets.all(Global.paddingBody),
                              child: buildForm(
                                  context: context,
                                  formKey: _formKey,
                                  isEditing: _isEditing,
                                  userData: user,
                                  onEditHandler: () {
                                    setState(() {
                                      _isEditing = !_isEditing;
                                    });
                                  },
                                  onLogoutHandler: () {
                                    showConfirmLogoutModal(
                                      context: context,
                                      onProceedHandler: _logOut,
                                    );
                                  }),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: (_isEditing)
          ? EBButton(
              onPressed: () {},
              text: 'Save',
              theme: EBButtonTheme.primary,
              icon: const Icon(FeatherIcons.arrowRight, size: EBFontSize.normal),
            )
          : null,
      bottomNavigationBar: const EBAppBarBottom(activeIndex: 4),
    );
  }
}
