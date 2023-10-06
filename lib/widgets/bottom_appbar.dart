import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';

class EBBottomAppBar extends StatelessWidget {
  const EBBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomAppBar(
      color: Colors.white,
      child: EBBottomAppBarContents(),
    );
  }
}

class EBBottomAppBarContents extends StatelessWidget {
  const EBBottomAppBarContents({super.key});

  @override
  Widget build(BuildContext context) {
    double paddingY = 10.0;
    double iconSize = 25.0;

    List<BottomNavigationBarItem> links = [
      BottomNavigationBarItem(
        label: 'Account',
        icon: Container(
          padding: EdgeInsets.symmetric(vertical: paddingY),
          child: Icon(FeatherIcons.settings, size: iconSize),
        ),
      ),
      BottomNavigationBarItem(
        label: 'People',
        icon: Container(
          padding: EdgeInsets.symmetric(vertical: paddingY),
          child: Icon(FeatherIcons.users, size: iconSize),
        ),
      ),
      BottomNavigationBarItem(
        label: 'Home',
        icon: Container(
          padding: EdgeInsets.symmetric(vertical: paddingY),
          child: Icon(FeatherIcons.home, size: iconSize),
        ),
      ),
    ];

    return BottomNavigationBar(items: links);
  }
}
