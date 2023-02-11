import 'package:color_picker/src/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HexColorPicker extends StatelessWidget {
  final Color initialColor;
  final ValueChanged<Color>? onChanged;

  const HexColorPicker({
    super.key,
    required this.initialColor,
    this.onChanged,
  });

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
        // TODO: allow all inputs and fallback to current value if invalid
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
