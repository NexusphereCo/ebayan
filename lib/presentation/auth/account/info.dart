import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/widgets/shared/appbar_bottom.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBAppBar(),
      drawer: const EBDrawer(),
      body: Stack(children: [
        EBTypography.h1(text: 'Account Information'),
      ]),
      bottomNavigationBar: const EBAppBarBottom(activeIndex: 4),
    );
  }
}
