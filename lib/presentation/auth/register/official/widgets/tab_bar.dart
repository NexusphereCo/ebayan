import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:flutter/material.dart';

IgnorePointer buildTabBar(TabController tabController) => IgnorePointer(
      child: TabBar(
        controller: tabController,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: EBColor.primary[50],
          border: Border(bottom: BorderSide(color: EBColor.primary, width: 2.0)),
        ),
        tabs: [
          Tab(
            child: Text(
              'Information',
              style: TextStyle(
                fontFamily: EBTypography.fontFamily,
                color: EBColor.primary,
              ),
            ),
          ),
          Tab(
            child: Text(
              'Barangay',
              style: TextStyle(
                fontFamily: EBTypography.fontFamily,
                color: EBColor.primary,
              ),
            ),
          ),
          Tab(
            child: Text(
              'Credentials',
              style: TextStyle(
                fontFamily: EBTypography.fontFamily,
                color: EBColor.primary,
              ),
            ),
          ),
        ],
      ),
    );
