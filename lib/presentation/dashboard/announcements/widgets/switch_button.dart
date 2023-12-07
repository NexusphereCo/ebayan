import 'package:ebayan/constants/colors.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({super.key});

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool light = true;

  final MaterialStateProperty<Icon?> thumbIcon = MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(FeatherIcons.check);
      }
      return const Icon(FeatherIcons.x);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Switch(
          value: light,
          onChanged: (bool value) {
            setState(() {
              light = value;
            });
          },
          activeTrackColor: EBColor.primary[100],
          activeColor: EBColor.primary,
        ),
      ],
    );
  }
}
