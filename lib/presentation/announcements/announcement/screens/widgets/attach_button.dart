import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/icons.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/presentation/dashboard/widgets/card_sphere.dart';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class RenderAttachButton extends StatefulWidget {
  const RenderAttachButton({super.key});

  @override
  State<RenderAttachButton> createState() => _RenderAttachButtonState();
}

class _RenderAttachButtonState extends State<RenderAttachButton> {
  CardOptions? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<CardOptions>(
      offset: const Offset(0, -75),
      icon: Icon(
        FeatherIcons.plusCircle,
        color: EBColor.primary,
      ),
      initialValue: selectedMenu,
      onSelected: (CardOptions item) {},
      itemBuilder: (BuildContext context) => <PopupMenuEntry<CardOptions>>[
        const PopupMenuItem<CardOptions>(
          value: CardOptions.itemOne,
          height: 30,
          child: Row(
            children: [
              Icon(EBIcons.clip, size: EBFontSize.h1),
              SizedBox(width: 5),
              Text('Add Attachment(s)', style: TextStyle(fontSize: EBFontSize.label)),
            ],
          ),
        ),
        const PopupMenuItem<CardOptions>(
          value: CardOptions.itemTwo,
          height: 30,
          child: Row(
            children: [
              Icon(EBIcons.image, size: EBFontSize.h1),
              SizedBox(width: 5),
              Text('Add Photo', style: TextStyle(fontSize: EBFontSize.label)),
            ],
          ),
        ),
      ],
    );
  }
}
