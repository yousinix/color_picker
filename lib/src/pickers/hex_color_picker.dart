import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/color_utils.dart';

class HexColorPicker extends StatelessWidget {
  const HexColorPicker({
    super.key,
    required this.initialColor,
    this.onChanged,
  });

  final Color initialColor;
  final ValueChanged<Color>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 6,
      initialValue: initialColor.toHex(
        leadingHashSign: false,
      ),
      decoration: const InputDecoration(
        prefixText: '#',
        counterText: '',
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'[0-9a-fA-F]'),
        ),
      ],
      onChanged: (value) {
        if (value.length != 6) return;

        final newColor = ColorUtils.fromHex(value);
        onChanged?.call(newColor);
      },
    );
  }
}
