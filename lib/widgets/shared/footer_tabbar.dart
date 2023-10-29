import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/widgets/shared/footer.dart';
import 'package:flutter/material.dart';

class TabBarFooter extends StatelessWidget {
  const TabBarFooter({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
          controller: _tabController,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
          indicator: BoxDecoration(
            border: Border(top: BorderSide(color: EBColor.primary, width: 2.0)),
          ),
          tabs: [
            Tab(
              child: Text(
                'Personal Information',
                style: TextStyle(
                  fontFamily: EBTypography.fontFamily,
                  color: EBColor.primary,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Login Credentials',
                style: TextStyle(
                  fontFamily: EBTypography.fontFamily,
                  color: EBColor.primary,
                ),
              ),
            ),
          ],
        ),
        const EBFooter(),
      ],
    );
  }
}
