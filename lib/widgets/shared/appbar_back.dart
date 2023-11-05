import 'package:ebayan/constants/colors.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class EBAppBarBack extends StatefulWidget implements PreferredSizeWidget {
  final Widget? title;

  const EBAppBarBack({Key? key, this.title}) : super(key: key);

  @override
  State<EBAppBarBack> createState() => _EBAppBarBackState();

  @override
  Size get preferredSize => const Size.fromHeight(65.0);
}

class _EBAppBarBackState extends State<EBAppBarBack> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: widget.title,
      iconTheme: IconThemeData(color: EBColor.primary),
      leading: Container(
        margin: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
        child: IconButton(
          icon: const Icon(FeatherIcons.arrowLeft),
          color: EBColor.primary,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: EBColor.light,
      elevation: 0,
    );
  }
}
