import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/icons.dart';
import 'package:flutter/material.dart';

class EBAppBarBack extends StatefulWidget implements PreferredSizeWidget {
  const EBAppBarBack({Key? key}) : super(key: key);

  @override
  State<EBAppBarBack> createState() => _EBAppBarBackState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _EBAppBarBackState extends State<EBAppBarBack> {
  @override
  Widget build(BuildContext context) {
    const iconSize = 20.0;

    return AppBar(
      iconTheme: const IconThemeData(color: EBColor.primary),
      leading: const Icon(
        EBIcons.menu,
        size: iconSize,
        color: EBColor.dark,
      ),
      backgroundColor: EBColor.light,
      elevation: 1,
    );
  }

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
