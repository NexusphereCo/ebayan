import 'package:ebayan/constants/colors.dart';
import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({super.key});

  @override
  State<SwitchButton> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchButton> {
  bool light = true;

  final MaterialStateProperty<Icon?> thumbIcon = MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
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
