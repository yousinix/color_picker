import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'color_utils.dart';

class ColorPicker extends StatelessWidget {
  final ValueChanged<Color>? onChange;

  const ColorPicker({super.key, this.onChange});

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
      onChanged: (value) {
        if (value.length != 6) return;
        onChange?.call(ColorUtils.fromHex(value));
      },
    );
  }
}
