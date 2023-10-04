import 'package:ebayan/constants/typography.dart';
import 'package:flutter/material.dart';

class EBTextBox extends StatelessWidget {
  final String? _placeholder;
  final String _label;
  final IconData _icon;
  final String _type;
  final String? _value;

  const EBTextBox({super.key, String? placeholder, required String label, required IconData icon, String? value, required String type})
      : _type = type,
        _value = value,
        _icon = icon,
        _label = label,
        _placeholder = placeholder;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(_icon),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EBTypography.b(text: _label),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  obscureText: (_type == 'text') ? false : true,
                  decoration: InputDecoration(
                    hintText: _placeholder,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
