import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 6,
      initialValue: 'FFFFFF',
      decoration: const InputDecoration(
        prefixText: '#',
        counterText: '',
      ),
      inputFormatters: [
        // TODO: allow all inputs and fallback to current value if invalid
        FilteringTextInputFormatter.allow(
          RegExp(r'[0-9a-fA-F]'),
        ),
      ],
    );
  }
}
