import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/data/viewmodel/user_view_model.dart';
import 'package:ebayan/presentation/auth/account/widgets/form.dart';
import 'package:ebayan/widgets/components/loading.dart';
import 'package:ebayan/widgets/layout_components/appbar_bottom.dart';
import 'package:ebayan/widgets/layout_components/appbar_top.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => AccountScreenState();
}

class AccountScreenState extends State<AccountScreen> {
  final GlobalKey<AccountScreenState> _widgetKey = GlobalKey<AccountScreenState>();
  final UserController _userController = UserController();

  Future<UserViewModel> _fetchUserData() async => await _userController.getCurrentUserInfo();

  void refresh() => setState(() {});

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
              Asset.accInfoBackdrop,
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
                const SizedBox(height: Spacing.md),
                FutureBuilder(
                  key: _widgetKey,
                  future: _fetchUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return EBCircularLoadingIndicator(
                        height: MediaQuery.of(context).size.height * 0.5,
                        strokeColor: EBColor.green,
                      );
                    } else {
                      final UserViewModel user = snapshot.data!;

                      return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                        return AccountInfoForm(userData: user, parent: this);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const EBAppBarBottom(activeIndex: 4),
    );
  }
}
